Class {
	#name : #ToAntDesignIconProviderGenerator,
	#superclass : #Object,
	#category : #'Toplo-Imported-Icons-AntDesign'
}

{ #category : #'_code generating' }
ToAntDesignIconProviderGenerator class >> categoryNameFromFileName: aFileName [

	^ ($- split: ($. split: aFileName) first) first asLowercase
]

{ #category : #'_code generating' }
ToAntDesignIconProviderGenerator class >> generateIconProviderClassesFromSrcDirectotyNamed: aSrcDirName [

	| newClass |
	newClass := self classInstaller make: [ :builder |
		            | newClassName cat |
		            newClassName := 'ToAntDesignIconProvider'.
		            cat := 'Toplo-Imported-Icons-AntDesign' asSymbol.
		            builder
			            superclass: ToImportedIconProvider;
			            name: newClassName;
			            category: cat ].
	ToIconStyle subclassesDo: [ :style |
		self
			generateIconProviderMethodsInClass: newClass
			fromSrcDirectoryNamed: aSrcDirName
			style: style ]
]

{ #category : #'_code generating' }
ToAntDesignIconProviderGenerator class >> generateIconProviderMethodsInClass: aClass fromSrcDirectoryNamed: aSrcDirName style: anIconStyle [
	" 
	generate the material design icon provider classes
	If the icons are in the src directory (from Ant design github repository), to generate outlined icons : 
	ToAntSvgIconProvider addIconMethodsInClass: ToAntSvgIconProvider fromFlatDir: 'src' style: ToIconOutlinedStyle new.
	"

	| styleDir |
	styleDir := aSrcDirName , '/' , anIconStyle prefix.
	styleDir asFileReference exists ifFalse: [ ^ self ].
	self
		generateIconProviderMethodsInClass: aClass
		withIcons: (styleDir asFileReference entries collect: [ :each |
				 (self iconNameFromFileName: each basename)
				 -> ((self categoryNameFromFileName: each basename)
					  -> each readStream contents) ])
		style: anIconStyle
]

{ #category : #'_code generating' }
ToAntDesignIconProviderGenerator class >> generateIconProviderMethodsInClass: aClass withIcons: aCollection style: anIconStyle [

	| unloadable loaded unloadableCode loadedCode |
	aCollection ifEmpty: [ ^ self ].
	unloadable := #(  ).
	loaded := #(  ).
	aCollection do: [ :assoc |
		assoc ifNotNil: [
			| loadable |
			loadable := ([ BlSvgConverter convertFromString: assoc value value ]
				             on: Error
				             do: [  ]) notNil.
			loadable
				ifTrue: [ | code  |
					loaded := loaded copyWith: assoc key asSymbol.
					code := assoc value value copyReplaceAll: String lf with: String space asTokens: false.
					aClass class
						compile:
						anIconStyle prefix, '_', assoc key, String cr , '^''' , code , ''''
						classified: assoc value key ]
				ifFalse: [ unloadable := unloadable copyWith: assoc key asSymbol ] ] ].

	unloadableCode := String streamContents: [ :stream |
		                  unloadable do: [ :symb |
			                  stream nextPutAll: symb printString.
			                  stream nextPutAll: ' ' ] ].
	loadedCode := String streamContents: [ :stream |
		              loaded do: [ :symb |
			              stream nextPutAll: symb printString.
			              stream nextPutAll: ' ' ] ].
	aClass class
		compile: '_', anIconStyle prefix, '_unloadable' , String cr , '^ #( ' , unloadableCode , ' )'
		classified: #'_private - loaded and unloadable'.
	aClass class
		compile: '_', anIconStyle prefix, '_loaded' , String cr , '^ #( ' , loadedCode , ' )'
		classified: #'_private - loaded and unloadable'
]

{ #category : #'_code generating' }
ToAntDesignIconProviderGenerator class >> iconNameFromFileName: aFileName [

	^ (($. split: aFileName) first replaceAll: $- with: Character space)
		  asCamelCase asValidSelector
]
