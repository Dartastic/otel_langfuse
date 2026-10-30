// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:otel_langfuse/otel_langfuse.dart';

/// Traces Langfuse calls with OpenTelemetry.
///
/// `otel_langfuse` depends on the OpenTelemetry API only, so the application
/// initializes an SDK once at startup. Wrap each Langfuse call in
/// [tracedLangfuse]; the `invoke` callback makes the real call and reports what
/// came back, which is recorded on the span.
Future<void> main() async {
  await OTel.initialize(serviceName: 'langfuse-example');

  // Traces a Langfuse call.
  final langfuseId = await tracedLangfuse<String>(
    operation: 'create',
    invoke: () async {
      // Make the Langfuse call here, then report what it returned.
      const id = 'langfuse_8f3a2c';
      return const LangfuseCallResult(
          value: id,
          result: LangfuseResult(
              projectId: 'project_8f3a2c',
              environment: 'example',
              surface: 'example',
              traceId: 'trace_8f3a2c',
              observationId: 'observation_8f3a2c',
              observationType: 'standard',
              parentObservationId: 'parentobservation_8f3a2c',
              sessionId: 'session_8f3a2c',
              userId: 'user_8f3a2c',
              release: 'example',
              versionTag: '1',
              promptName: 'example',
              promptVersion: 1,
              modelName: 'standard',
              modelProvider: 'standard',
              tokensInput: 128,
              tokensOutput: 128,
              tokensTotal: 128,
              costUsdMicros: 1,
              scoreName: 'example',
              scoreValue: 0.5,
              evalName: 'example',
              datasetName: 'example',
              datasetItems: 120,
              statusCode: 201,
              errorCode: 'example',
              errorMessage: 'example'));
    },
  );
  OTelLog.info('tracedLangfuse create returned $langfuseId');

  // Calls that should not be traced, such as health checks, run inside
  // runWithoutLangfuseInstrumentationAsync.
  await runWithoutLangfuseInstrumentationAsync(
    () => tracedLangfuse<String>(
      operation: 'create',
      invoke: () async {
        const id = 'langfuse_8f3a2c';
        return const LangfuseCallResult(
            value: id,
            result: LangfuseResult(
                projectId: 'project_8f3a2c',
                environment: 'example',
                surface: 'example',
                traceId: 'trace_8f3a2c',
                observationId: 'observation_8f3a2c',
                observationType: 'standard',
                parentObservationId: 'parentobservation_8f3a2c',
                sessionId: 'session_8f3a2c',
                userId: 'user_8f3a2c',
                release: 'example',
                versionTag: '1',
                promptName: 'example',
                promptVersion: 1,
                modelName: 'standard',
                modelProvider: 'standard',
                tokensInput: 128,
                tokensOutput: 128,
                tokensTotal: 128,
                costUsdMicros: 1,
                scoreName: 'example',
                scoreValue: 0.5,
                evalName: 'example',
                datasetName: 'example',
                datasetItems: 120,
                statusCode: 201,
                errorCode: 'example',
                errorMessage: 'example'));
      },
    ),
  );

  await OTel.shutdown();
}
