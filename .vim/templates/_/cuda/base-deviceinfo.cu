#include <iostream>

int main() {
	int runtimeVersion;
	cudaRuntimeGetVersion(&runtimeVersion);
	std::printf("Runtime Version: %d.%d.%d\n",
			runtimeVersion/1000, runtimeVersion%1000/10, runtimeVersion%10);

	int driverVersion;
	cudaDriverGetVersion(&driverVersion);
	std::printf("Driver Version:  %d.%d.%d\n",
			driverVersion/1000, driverVersion%1000/10, driverVersion%10);

	int numDevices;
	cudaGetDeviceCount(&numDevices);

	for (int i = 0; i < numDevices; i++) {
		cudaDeviceProp prop;
		cudaGetDeviceProperties(&prop, i);
		std::printf("Device number: %d\n", i);
		std::printf("  Name:                %s\n", prop.name);
		std::printf("  Compute Capability:  %d.%d\n", prop.major, prop.minor);
		std::printf("  totalGlobalMem (GB): %zu\n", prop.totalGlobalMem/(1000*1000*1000));
		std::printf("  maxThreadsPerBlock:  %d\n", prop.maxThreadsPerBlock);
		std::printf("  maxThreadsDim:       (%d, %d, %d)\n",
				prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2]);
		std::printf("  maxGridSize:         (%d, %d, %d)\n",
				prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2]);
	}

	return 0;
}
