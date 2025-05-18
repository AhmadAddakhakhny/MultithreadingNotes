########################################################################
#####							Top level Makefile for Project_Name
########################################################################

project_type=release 			# Values [release, debug, test]
compiler_options = "."
config=

# Generate build files
all:
	test -d build/out/${project_type} || (mkdir -p build/out/${project_type})
	cd build/out/${project_type} && cmake ${compiler_options} ../../.. && cmake --build . ${config}
	@echo "################## Build files genearation done."

# Generate and build for release 
r:
	$(MAKE) all project_type=release compiler_options=" -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS_RELEASE=-O3 -DCMAKE_C_FLAGS_RELEASE=-O3"
	cd build/out/release/app && ./app.exe
	@echo "################## Release Build Done."

# Generate and build for debug with debug logs
d:
	$(MAKE) all project_type=debug compiler_options="-DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_FLAGS_RELEASE=-O0 -DCMAKE_C_FLAGS_RELEASE=-O0 -DDEBUG_LOG=ON"
	cd build/out/debug/app && ./app.exe
	@echo "################## Debug Build Done."

# Generate and build for unit test 
test:
	$(MAKE) all project_type=test compiler_options=-DTEST_ENABLED=ON
	cd build/out/test/tests && ./test.exe
	@echo "################## Unit Test Done."

# Generate and build for debug with sanitizer
san:
	$(MAKE) all project_type=debug compiler_options=-DSANITIZER_ENABLED=ON
	cd build/out/debug/app && ./app.exe
	@echo "################## Debug with asan Build Done."

# Run clang-tidy for project linting
lint:
	$(MAKE) all compiler_options=-DCLANG-TIDY_ENABLED=ON  config="--target app.exe_clangtidy"
	@echo "################## Lintting Done."

# Generate Doxygen documentation for the project
doc: all
	cd build/out/release && make docs
	@echo "################## Doxygen Generation Done"

# Format tracked files only
fmt:
	test -d build/out/fmt || (mkdir -p build/out/fmt)
	cd build/out/fmt/ && cmake -DENABLE_FORMAT_ONLY=ON ../../..
	@echo "################## Format Project Done"

# Clean release build files and binaries
cleanR:
	rm -rf build/out/release
	@echo "################## Clean Release Build Done"

# Clean debug build files and binaries
cleanD:
	rm -rf build/out/debug
	@echo "################## Clean Debug Build Done"

# Clean test build files and binaries
cleanTst:
	rm -rf build/out/test
	@echo "################## Clean Test Build Done"

# Clean generated doxygen docs
cleanDoc:
	cd docs && rm -rf html
		@echo "################## Clean Project Docs Done"

cleanFmt:
	rm -rf build/out/fmt
	@echo "################## Clean FMT Done"

# Clean all build files, binaries and generated doxygen docs
clean: cleanR cleanD cleanTst cleanDoc cleanFmt
	@echo "################## Clean All Project Done"
