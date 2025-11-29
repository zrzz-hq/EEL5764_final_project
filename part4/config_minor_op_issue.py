from gem5.components.boards.simple_board import SimpleBoard
from gem5.components.processors.simple_processor import SimpleProcessor
from gem5.components.cachehierarchies.ruby.mesi_two_level_cache_hierarchy import (
    MESITwoLevelCacheHierarchy,
)
from gem5.components.memory.single_channel import SingleChannelDDR4_2400
from gem5.components.processors.cpu_types import CPUTypes
from gem5.isas import ISA
from gem5.resources.resource import BinaryResource
from gem5.simulate.simulator import Simulator
from m5.objects import MinorFU, MinorFUPool, MinorDefaultIntFU, MinorDefaultIntMulFU, MinorDefaultIntDivFU, MinorDefaultMemFU, MinorDefaultMiscFU, MinorDefaultPredFU, MinorDefaultFloatSimdFU
import sys

cache_hierarchy = MESITwoLevelCacheHierarchy(
    l1d_size="16KiB",
    l1d_assoc=8,
    l1i_size="16KiB",
    l1i_assoc=8,
    l2_size="256KiB",
    l2_assoc=16,
    num_l2_banks=1,
)

memory = SingleChannelDDR4_2400()
processor = SimpleProcessor(cpu_type=CPUTypes.MINOR, isa=ISA.X86, num_cores=1)


# ----------- Part 4-------------

opLat = int(sys.argv[1]) if len(sys.argv) > 1 else 6
issueLat = int(sys.argv[2]) if len(sys.argv) > 2 else 1

class CustomFloatSimdFU(MinorDefaultFloatSimdFU):
    opLat = opLat
    issueLat = issueLat

# Create custom FU pool with modified FloatSimdFU
custom_fu_pool = MinorFUPool(funcUnits=[
    MinorDefaultIntFU(),
    MinorDefaultIntFU(), 
    MinorDefaultIntMulFU(),
    MinorDefaultIntDivFU(),
    CustomFloatSimdFU(), ##
    MinorDefaultPredFU(),
    MinorDefaultMemFU(),
    MinorDefaultMiscFU(),
])

processor.cores[0].core.executeFuncUnits = custom_fu_pool

# ---------------------

board = SimpleBoard(
    clk_freq="3GHz",
    processor=processor,
    memory=memory,
    cache_hierarchy=cache_hierarchy,
)

board.set_se_binary_workload(BinaryResource('../part2/daxpy'))

simulator = Simulator(board=board)
simulator.run()

