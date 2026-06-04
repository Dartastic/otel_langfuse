// Licensed under the Dartastic Pro Software License Agreement.
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';

import 'otel_langfuse_suppression.dart';

class LangfuseResult {
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

class LangfuseCallResult<T> {
  const LangfuseCallResult({required this.value, this.result});
  final T value;
  final LangfuseResult? result;
}

Future<T> tracedLangfuse<T>({
  required String operation,
  required Future<LangfuseCallResult<T>> Function() invoke,
  Tracer? tracer,
}) async {
  if (langfuseInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t = tracer ?? OTel.tracerProvider().getTracer('otel_langfuse');
  final span = t.startSpan('langfuse $operation', kind: SpanKind.client);
  try {
    span.addAttributes(
        OTel.attributes([OTel.attributeString('rpc.system', 'langfuse')]));
    span.addAttributes(
        OTel.attributes([OTel.attributeString('rpc.method', operation)]));
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.projectId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('langfuse.project.id', res.projectId!)]));
      }
      if (res.environment != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('langfuse.environment', res.environment!)]));
      }
      if (res.surface != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('langfuse.surface', res.surface!)]));
      }
      if (res.traceId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('langfuse.trace.id', res.traceId!)]));
      }
      if (res.observationId != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('langfuse.observation.id', res.observationId!)
        ]));
      }
      if (res.observationType != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              'langfuse.observation.type', res.observationType!)
        ]));
      }
      if (res.parentObservationId != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              'langfuse.observation.parent_id', res.parentObservationId!)
        ]));
      }
      if (res.sessionId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('langfuse.session.id', res.sessionId!)]));
      }
      if (res.userId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('langfuse.user.id', res.userId!)]));
      }
      if (res.release != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('langfuse.release', res.release!)]));
      }
      if (res.versionTag != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('langfuse.version', res.versionTag!)]));
      }
      if (res.promptName != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('langfuse.prompt.name', res.promptName!)]));
      }
      if (res.promptVersion != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeInt('langfuse.prompt.version', res.promptVersion!)
        ]));
      }
      if (res.modelName != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('gen_ai.request.model', res.modelName!)]));
      }
      if (res.modelProvider != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('gen_ai.system', res.modelProvider!)]));
      }
      if (res.tokensInput != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeInt('gen_ai.usage.input_tokens', res.tokensInput!)
        ]));
      }
      if (res.tokensOutput != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeInt('gen_ai.usage.output_tokens', res.tokensOutput!)
        ]));
      }
      if (res.tokensTotal != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('langfuse.tokens.total', res.tokensTotal!)]));
      }
      if (res.costUsdMicros != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeInt('langfuse.cost.usd_micros', res.costUsdMicros!)
        ]));
      }
      if (res.scoreName != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('langfuse.score.name', res.scoreName!)]));
      }
      if (res.scoreValue != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeDouble('langfuse.score.value', res.scoreValue!)]));
      }
      if (res.evalName != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('langfuse.eval.name', res.evalName!)]));
      }
      if (res.datasetName != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('langfuse.dataset.name', res.datasetName!)]));
      }
      if (res.datasetItems != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('langfuse.dataset.items', res.datasetItems!)]));
      }
      if (res.statusCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('http.response.status_code', res.statusCode!)]));
      }
      if (res.errorCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('langfuse.error.code', res.errorCode!)]));
      }
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400);
      if (fail) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              ErrorResource.errorType.key, res.errorCode ?? 'langfuse.error')
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
