"
ToMaterialDesignIconProviderGenerator generateIconProviderClassesFromSrcDirectotyNamed: 'material\_design\_src'.

"
Class {
	#name : #ToMaterialDesignIconProviderGenerator,
	#superclass : #Object,
	#category : #'Toplo-Imported-Icons-MaterialDesign'
}

{ #category : #'_code generating' }
ToMaterialDesignIconProviderGenerator class >> generateIconMethodsInClass: aIconProviderClass fromSrcDirectoryNamed: aSrcDirName [

	| icons loadedMap unloadableMap |
	loadedMap := IdentityDictionary new.
	unloadableMap := IdentityDictionary new.
	icons := aSrcDirName asFileReference entries collect: [ :eachIconDir |
		         eachIconDir basename ].

	icons do: [ :eachIcon |
		ToIconStyle subclassesDo: [ :style |
			| iconStylePath prefix |
			prefix := style prefix.
			iconStylePath := aSrcDirName , '/' , eachIcon , '/materialicons'
			                 , prefix.

			iconStylePath asFileReference exists ifTrue: [
				| iconSvgPath svgFile |
				loadedMap at: style ifAbsentPut: OrderedCollection new.
				unloadableMap at: style ifAbsentPut: OrderedCollection new.

				iconSvgPath := iconStylePath , '/24px.svg'.
				svgFile := iconSvgPath asFileReference.

				svgFile exists ifTrue: [
					| loadable svgContents |
					svgContents := iconSvgPath asFileReference readStream contents.
					loadable := ([ BlSvgConverter convertFromString: svgContents ]
						             on: Error
						             do: [  ]) notNil.
					loadable
						ifTrue: [
							| code loaded |
							loaded := loadedMap at: style.
							loaded add: eachIcon asSymbol.

							code := svgContents
								        copyReplaceAll: String lf
								        with: String space
								        asTokens: false.
							aIconProviderClass class
								compile:
								prefix , '_' , eachIcon , String cr , '^''' , code , ''''
								classified: eachIcon ]
						ifFalse: [
							| unloadable |
							unloadable := unloadableMap at: style.
							unloadable add: eachIcon asSymbol ] ] ] ] ].

	ToIconStyle subclassesDo: [ :style |
		| prefix |
		prefix := style prefix.
		loadedMap at: style ifPresent: [ :loaded |
			| code |
			code := String streamContents: [ :stream |
				        loaded do: [ :symb |
					        stream nextPutAll: symb printString.
					        stream nextPutAll: ' ' ] ].
			aIconProviderClass class
				compile:
				'_' , prefix , '_loaded' , String cr , '^ #( ' , code , ' )'
				classified: #'_private - loaded and unloadable' ].

		unloadableMap at: style ifPresent: [ :unloadable |
			| code |
			code := String streamContents: [ :stream |
				        unloadable do: [ :symb |
					        stream nextPutAll: symb printString.
					        stream nextPutAll: ' ' ] ].

			aIconProviderClass class
				compile:
				'_' , prefix , '_unloadable' , String cr , '^ #( ' , code , ' )'
				classified: #'_private - loaded and unloadable' ] ]
]

{ #category : #'_code generating' }
ToMaterialDesignIconProviderGenerator class >> generateIconProviderClassesFromSrcDirectotyNamed: aSrcDirName [
	" 
	generate the material design icon provider classes
	If the icons are in the src directory (from material design github repository) : 
	ToMaterialDesignIconProvider generateIconProviderClassesFromSrcDirectotyNamed: 'src'.
	"

	aSrcDirName asFileReference entries do: [ :eachTypeDir |
		(eachTypeDir basename beginsWith: '.') ifFalse: [
			| newClass iconType |
			newClass := self classInstaller make: [ :builder |
				            | newClassName cat |
				            iconType := eachTypeDir basename.
				            newClassName := 'ToMaterialDesign'
				                            , iconType capitalized
				                            , 'IconProvider'.
				            cat := 'Toplo-Imported-Icons-MaterialDesign' asSymbol.
				            builder
					            superclass: ToMaterialDesignIconProvider;
					            name: newClassName;
					            category: cat ].
			newClass class
				compile:
					'_iconType' , String cr , String cr , String tab , '^ #'''
					, iconType , ''''
				classified: '_private - icon type'.
			self
				generateIconMethodsInClass: newClass
				fromSrcDirectoryNamed: aSrcDirName , '/' , iconType ] ]
]