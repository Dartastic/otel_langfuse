// Licensed under the Dartastic Pro Software License Agreement.
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:dartastic_opentelemetry/testing.dart';
import 'package:otel_langfuse/otel_langfuse.dart';
import 'package:test/test.dart';

void main() {
  late TestHarness harness;
  late InMemorySpanExporter spans;

  setUpAll(() async {
    harness = await maybeInitializeOtelForTest(
      serviceName: 'otel_langfuse-test',
    );
    spans = harness.spans;
  });

  setUp(() => harness.clear());

  Map<String, Object> attrsOf(Span s) =>
      {for (final a in s.attributes.toList()) a.key: a.value};

  test('generation records model + tokens + cost', () async {
    await tracedLangfuse<String>(
      operation: 'observation.create',
      invoke: () async => const LangfuseCallResult(
        value: 'ok',
        result: LangfuseResult(
          observationType: 'generation',
          modelName: 'claude-opus-4-7',
          modelProvider: 'anthropic',
          tokensInput: 1200,
          tokensOutput: 300,
          tokensTotal: 1500,
          costUsdMicros: 15000,
        ),
      ),
    );
    final a = attrsOf(spans.findSpanByName('langfuse observation.create')!);
    expect(a['gen_ai.request.model'], 'claude-opus-4-7');
    expect(a['gen_ai.usage.input_tokens'], 1200);
    expect(a['langfuse.cost.usd_micros'], 15000);
  });

  test('score.create records score', () async {
    await tracedLangfuse<String>(
      operation: 'score.create',
      invoke: () async => const LangfuseCallResult(
        value: 'ok',
        result: LangfuseResult(
          scoreName: 'helpfulness',
          scoreValue: 4.5,
        ),
      ),
    );
    final a = attrsOf(spans.findSpanByName('langfuse score.create')!);
    expect(a['langfuse.score.name'], 'helpfulness');
    expect(a['langfuse.score.value'], 4.5);
  });

  test('error code sets span error', () async {
    await tracedLangfuse<String>(
      operation: 'observation.create',
      invoke: () async => const LangfuseCallResult(
        value: 'ok',
        result: LangfuseResult(
          errorCode: 'unauthorized',
          statusCode: 401,
        ),
      ),
    );
    expect(
      spans.findSpanByName('langfuse observation.create')!.status,
      SpanStatusCode.Error,
    );
  });

  test('suppression skips spans', () async {
    await runWithoutLangfuseInstrumentationAsync(() async {
      await tracedLangfuse<String>(
        operation: 'trace.create',
        invoke: () async => const LangfuseCallResult(value: 'v'),
      );
    });
    expect(spans.findSpansStartingWith('langfuse '), isEmpty);
  });
}
