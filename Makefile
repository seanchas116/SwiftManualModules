SWIFT_LIBS_PATH = /Library/Developer/Toolchains/swift-latest.xctoolchain/usr/lib/swift/macosx

Main: Main.o CModule.o Module.o
	clang -L$(SWIFT_LIBS_PATH) -Wl,-rpath,$(SWIFT_LIBS_PATH) Main.o CModule.o Module.o -o Main
Main.o: Module.swiftmodule
	swiftc -emit-object -I CModule -I . Main.swift
CModule.o:
	clang -c CModule/CModule.c -o CModule.o
Module.o:
	swiftc -emit-object -module-name Module -parse-as-library Module/Module.swift
Module.swiftmodule:
	swiftc -emit-module -module-name Module -parse-as-library Module/Module.swift
clean:
	rm Main Main.o CModule.o Module.o Module.swiftdoc Module.swiftmodule
