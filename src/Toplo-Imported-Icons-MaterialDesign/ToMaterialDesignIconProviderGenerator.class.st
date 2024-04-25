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
		{
			ToIconOutlinedStyle.
			ToIconSharpStyle.
			ToIconRoundStyle.
			ToIconTwotoneStyle } do: [ :style |
			| loadable iconSvgPath svgFile svgContents |
			iconSvgPath := aSrcDirName , '/' , eachIcon , '/materialicons'
			               , style prefix , '/24px.svg'.
			svgFile := iconSvgPath asFileReference.
			svgFile exists ifTrue: [
				svgContents := iconSvgPath asFileReference readStream contents.
				loadable := ([ BlSvgConverter convertFromString: svgContents ]
					             on: Error
					             do: [  ]) notNil.
				loadable
					ifTrue: [
						| code loaded |
						loaded := loadedMap
							          at: style
							          ifAbsentPut: [ OrderedCollection new ].
						loaded add: eachIcon asSymbol.

						code := svgContents
							        copyReplaceAll: String lf
							        with: String space
							        asTokens: false.
						aIconProviderClass class
							compile:
							style prefix , '_' , eachIcon , String cr , '^''' , code , ''''
							classified: eachIcon ]
					ifFalse: [
						| unloadable |
						unloadable := unloadableMap
							              at: style
							              ifAbsentPut: [ OrderedCollection new ].
						unloadable add: eachIcon asSymbol ] ] ] ].

	{
		ToIconOutlinedStyle.
		ToIconSharpStyle.
		ToIconRoundStyle.
		ToIconTwotoneStyle } do: [ :style |
		| unloadableCode loadedCode loaded unloadable |
		loaded := loadedMap at: style ifAbsent: [ OrderedCollection new ].
		unloadable := unloadableMap
			              at: style
			              ifAbsent: [ OrderedCollection new ].

		unloadableCode := String streamContents: [ :stream |
			                  unloadable do: [ :symb |
				                  stream nextPutAll: symb printString.
				                  stream nextPutAll: ' ' ] ].
		loadedCode := String streamContents: [ :stream |
			              loaded do: [ :symb |
				              stream nextPutAll: symb printString.
				              stream nextPutAll: ' ' ] ].
		aIconProviderClass class
			compile: '_' , style prefix , '_unloadable' , String cr , '^ #( '
				, unloadableCode , ' )'
			classified: #'_private - loaded and unloadable'.
		aIconProviderClass class
			compile:
				'_' , style prefix , '_loaded' , String cr , '^ #( ' , loadedCode
				, ' )'
			classified: #'_private - loaded and unloadable' ]
]

{ #category : #'_code generating' }
ToMaterialDesignIconProviderGenerator class >> generateIconProviderClassesFromSrcDirectotyNamed: aSrcDirName [
	" 
	generate the material design icon provider classes
	If the icons are in the src directory (from material design github repository) : 
	ToMaterialDesignIconProvider generateIconProviderClassesFromSrcDirectotyNamed: 'src'.
	"

	aSrcDirName asFileReference entries do: [ :eachTypeDir |
		| newClass iconType |
		newClass := self classInstaller make: [ :builder |
			            | newClassName cat |
			            iconType := eachTypeDir basename.
			            newClassName := 'ToMaterialDesign'
			                            , iconType capitalized , 'IconProvider'.
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
			fromSrcDirectoryNamed: aSrcDirName , '/' , iconType.
 ]
]

{ #category : #'_code generating' }
ToMaterialDesignIconProviderGenerator class >> listElementWithAllIcons [

	| l  |
	l := ToListElement new.
	l withRowNumbers.
	l selectionMode beneathOption: ToListSelectionOption none.
	l selectionMode overOption: ToListSelectionOption grouped.

	self subclassesDo: [ :providerCls |
		ToIconStyle allSubclassesDo: [ :styleCls |
			| s |
			s := #'_loaded'.
			l dataAccessor addAll: ((providerCls perform: s) collect: [:n | n -> (providerCls -> styleCls) ]) ] ].

	l nodeBuilder: [ :node :holder |
		| styleCls typeLab typePane iclab iclabPane imPane providerCls iconName |
		providerCls := holder dataItem value key.
		styleCls := holder dataItem value value.
		iconName := holder dataItem key.
		node layout: BlLinearLayout horizontal.
		iclabPane := ToPane new layout: BlFrameLayout new.
		iclabPane withNullSkin.
		iclabPane vFitContent.
		iclabPane width: 150.
		typePane := ToPane new layout: BlFrameLayout new.
		typePane withNullSkin.
		typePane vFitContent.
		typePane width: 150.
		iclab := ToLabel text: iconName.
		iclab constraintsDo: [ :c | c frame vertical alignCenter ].
		iclabPane addChild: iclab.
		typeLab := ToLabel text: providerCls _iconType.
		typeLab constraintsDo: [ :c | c frame vertical alignCenter ].
		typePane addChild: typeLab.
		imPane := ToPane new layout: BlFrameLayout new.
		imPane fitContent.
		imPane addChild: ((ToImage inner: (providerCls perform: iconName asSymbol))
				 size: 24 asPoint;
				 yourself).
		node addChildren: {
				typePane.
				iclabPane.
				imPane }.
		node childrenDo: [ :child |
			child constraintsDo: [ :c | c linear vertical alignCenter ] ] ].
	^ l
]
