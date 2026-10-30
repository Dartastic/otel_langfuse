// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry_api/dartastic_opentelemetry_api.dart';

import 'otel_langfuse_suppression.dart';

class LangfuseResult {
  /// Creates a result.
  const LangfuseResult({
    this.projectId,
    this.environment,
    this.surface,
    this.traceId,
    this.observationId,
    this.observationType,
    this.parentObservationId,
    this.sessionId,
    this.userId,
    this.release,
    this.versionTag,
    this.promptName,
    this.promptVersion,
    this.modelName,
    this.modelProvider,
    this.tokensInput,
    this.tokensOutput,
    this.tokensTotal,
    this.costUsdMicros,
    this.scoreName,
    this.scoreValue,
    this.evalName,
    this.datasetName,
    this.datasetItems,
    this.statusCode,
    this.errorCode,
    this.errorMessage,
  });

  final String? projectId;
  final String? environment;
  final String? surface;
  final String? traceId;
  final String? observationId;
  final String? observationType;
  final String? parentObservationId;
  final String? sessionId;
  final String? userId;
  final String? release;
  final String? versionTag;
  final String? promptName;
  final int? promptVersion;
  final String? modelName;
  final String? modelProvider;
  final int? tokensInput;
  final int? tokensOutput;
  final int? tokensTotal;
  final int? costUsdMicros;
  final String? scoreName;
  final double? scoreValue;
  final String? evalName;
  final String? datasetName;
  final int? datasetItems;
  final int? statusCode;
  final String? errorCode;
  final String? errorMessage;
}

/// What a traced call returned: the value for the caller plus fields
/// recorded on the span.
class LangfuseCallResult<T> {
  /// Creates a call result.
  const LangfuseCallResult({required this.value, this.result});

  /// The value returned to the caller.
  final T value;
  final LangfuseResult? result;
}

Future<T> tracedLangfuse<T>({
  required String operation,
  required Future<LangfuseCallResult<T>> Function() invoke,
  APITracer? tracer,
}) async {
  if (langfuseInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t = tracer ?? OTelAPI.tracerProvider().getTracer('otel_langfuse');
  final span = t.startSpan('langfuse $operation', kind: SpanKind.client);
  try {
    span.addAttributes(OTelAPI.attributes(
        [OTelAPI.attributeString('rpc.system', 'langfuse')]));
    span.addAttributes(
        OTelAPI.attributes([OTelAPI.attributeString('rpc.method', operation)]));
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.projectId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('langfuse.project.id', res.projectId!)]));
      }
      if (res.environment != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('langfuse.environment', res.environment!)
        ]));
      }
      if (res.surface != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('langfuse.surface', res.surface!)]));
      }
      if (res.traceId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('langfuse.trace.id', res.traceId!)]));
      }
      if (res.observationId != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('langfuse.observation.id', res.observationId!)
        ]));
      }
      if (res.observationType != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'langfuse.observation.type', res.observationType!)
        ]));
      }
      if (res.parentObservationId != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'langfuse.observation.parent_id', res.parentObservationId!)
        ]));
      }
      if (res.sessionId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('langfuse.session.id', res.sessionId!)]));
      }
      if (res.userId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('langfuse.user.id', res.userId!)]));
      }
      if (res.release != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('langfuse.release', res.release!)]));
      }
      if (res.versionTag != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('langfuse.version', res.versionTag!)]));
      }
      if (res.promptName != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('langfuse.prompt.name', res.promptName!)
        ]));
      }
      if (res.promptVersion != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('langfuse.prompt.version', res.promptVersion!)
        ]));
      }
      if (res.modelName != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('gen_ai.request.model', res.modelName!)]));
      }
      if (res.modelProvider != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('gen_ai.system', res.modelProvider!)]));
      }
      if (res.tokensInput != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('gen_ai.usage.input_tokens', res.tokensInput!)
        ]));
      }
      if (res.tokensOutput != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('gen_ai.usage.output_tokens', res.tokensOutput!)
        ]));
      }
      if (res.tokensTotal != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeInt('langfuse.tokens.total', res.tokensTotal!)]));
      }
      if (res.costUsdMicros != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('langfuse.cost.usd_micros', res.costUsdMicros!)
        ]));
      }
      if (res.scoreName != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('langfuse.score.name', res.scoreName!)]));
      }
      if (res.scoreValue != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeDouble('langfuse.score.value', res.scoreValue!)
        ]));
      }
      if (res.evalName != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('langfuse.eval.name', res.evalName!)]));
      }
      if (res.datasetName != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('langfuse.dataset.name', res.datasetName!)
        ]));
      }
      if (res.datasetItems != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('langfuse.dataset.items', res.datasetItems!)
        ]));
      }
      if (res.statusCode != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('http.response.status_code', res.statusCode!)
        ]));
      }
      if (res.errorCode != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('langfuse.error.code', res.errorCode!)]));
      }
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400);
      if (fail) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              ErrorAttributes.errorType.key, res.errorCode ?? 'langfuse.error')
        ]));
        span.setStatus(SpanStatusCode.Error, res.errorMessage);
      }
    }
    return r.value;
  } catch (e, st) {
    span.recordException(e, stackTrace: st);
    span.setStatus(SpanStatusCode.Error, e.toString());
    rethrow;
  } finally {
    span.end();
  }
}
