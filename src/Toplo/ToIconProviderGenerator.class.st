"
If you want to test the svg file importer, you can generate the icon provider classes.

To generate the icon providers classes:
**For Ant design**
- ```ToIconProviderGenerator  generateIconProviderClassName: 'ToAntDesignIconProvider' fromSrcDirectotyNamed: 'ant_design_svg'```
- ant_design_svg should be the directory name where ant icons are stored
- Then open the list with all loadable icons with:  ```(ToImportedIconProvider listElementWithAllIconsInProviderClass: ToAntDesignIconProvider  ) openInSpace.```
- To open a particular icon by its name, send #iconNamed:inProvider: to the icon style of the icon : ```(ToIconFilledStyle iconNamed: 'alert' inProvider: ToAntDesignIconProvider) matchParent; openInSpace.```
- have a look at the ToAntDesignIconProvider class side. As an example, you have the #\_filled\_unloadable method that returns the array of all icon files of the filled style that the svg converter can't read (there are errors while reading the svg file)

[ant-design-icons.zip](https://github.com/user-attachments/files/15526663/ant-design-icons.zip)
"
Class {
	#name : #ToIconProviderGenerator,
	#superclass : #Object,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'code generating' }
ToIconProviderGenerator class >> generateIconProviderClassNamed: aClassname fromSrcDirectotyNamed: aSrcDirName [
	"
	ToIconProviderGenerator  generateIconProviderClassNamed: 'ToMaterialDesignIconProvider' fromSrcDirectotyNamed: 'material_design_svg'
	ToIconProviderGenerator  generateIconProviderClassNamed: 'ToAntDesignIconProvider' fromSrcDirectotyNamed: 'ant_design_svg' 
	"

	| newClass |
	newClass := self classInstaller make: [ :builder |
		            | cat |
		            cat := 'Toplo-Imported-Icons' asSymbol.
		            builder
			            superclass: ToImportedIconProvider;
			            name: aClassname;
			            category: cat ].
	ToIconStyle subclassesDo: [ :style |
		self
			generateIconProviderMethodsInClass: newClass
			fromSrcDirectoryNamed: aSrcDirName
			style: style ]
]

{ #category : #'code generating' }
ToIconProviderGenerator class >> generateIconProviderMethodsInClass: aClass fromSrcDirectoryNamed: aSrcDirName style: anIconStyle [
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
				 | categoryName iconName |
				 iconName := (($. split: each basename) first
					              replaceAll: $-
					              with: Character space) asCamelCase asValidSelector.
				 categoryName := ($- split: ($. split: each basename) first) first
					                 asLowercase.
				 iconName -> (categoryName -> each readStream contents) ])
		style: anIconStyle
]

{ #category : #'code generating' }
ToIconProviderGenerator class >> generateIconProviderMethodsInClass: aClass withIcons: iconAssocCollection style: anIconStyle [

	| unloadable loaded unloadableCode loadedCode stylePrefix |
	iconAssocCollection ifEmpty: [ ^ self ].

	stylePrefix := anIconStyle prefix.
	unloadable := #(  ).
	loaded := #(  ).

	iconAssocCollection do: [ :assoc |
		assoc ifNotNil: [
			| loadable |
			loadable := ([ BlSvgConverter convertFromString: assoc value value ]
				             on: Error
				             do: [  ]) notNil.
			loadable
				ifTrue: [
					| code |
					loaded := loaded copyWith: assoc key asSymbol.
					code := assoc value value
						        copyReplaceAll: String lf
						        with: String space
						        asTokens: false.
					aClass class
						compile:
						stylePrefix , '_' , assoc key , String cr , '^''' , code , ''''
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
		compile: '_' , stylePrefix , '_unloadable' , String cr , '^ #( '
			, unloadableCode , ' )'
		classified: #'_private - loaded and unloadable'.
	aClass class
		compile:
			'_' , stylePrefix , '_loaded' , String cr , '^ #( ' , loadedCode
			, ' )'
		classified: #'_private - loaded and unloadable'
]
