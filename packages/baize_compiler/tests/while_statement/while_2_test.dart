import 'package:baize_compiler/baize_compiler.dart';
import 'package:test/test.dart';
import '../utils.dart';

Future<void> main() async {
  const String title = 'While (2)';
  final BaizeProgramConstant program =
      await compileTestScript('while_statement', 'while_2.baize');

  test('$title - Bytecode', () async {
    final BaizeChunk chunk = extractChunk(program);
    final BaizeTestChunk expectedChunk = BaizeTestChunk();
    expectedChunk.addOpCode(BaizeOpCodes.opFalse);
    expectedChunk.addOpCode(BaizeOpCodes.opJumpIfFalse);
    expectedChunk.addCode(12);
    expectedChunk.addOpCode(BaizeOpCodes.opPop);
    expectedChunk.addOpCode(BaizeOpCodes.opBeginScope);
    expectedChunk.addOpCode(BaizeOpCodes.opLookup);
    expectedChunk.addConstant(0, 'out');
    expectedChunk.addOpCode(BaizeOpCodes.opConstant);
    expectedChunk.addConstant(1, 'c-0');
    expectedChunk.addOpCode(BaizeOpCodes.opCall);
    expectedChunk.addCode(1);
    expectedChunk.addOpCode(BaizeOpCodes.opPop);
    expectedChunk.addOpCode(BaizeOpCodes.opEndScope);
    expectedChunk.addOpCode(BaizeOpCodes.opAbsoluteJump);
    expectedChunk.addCode(0);
    expectedChunk.addOpCode(BaizeOpCodes.opPop);
    expect(tcpc(chunk), tcptc(expectedChunk));
  });

  test('$title - Channel', () async {
    final List<String> expected = <String>[];
    final List<String> actual = await executeTestScript(program);
    expect(actual, orderedEquals(expected));
  });
}
