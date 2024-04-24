Class {
	#name : #ToMaterialDesignIconProvider,
	#superclass : #ToImportedIconProvider,
	#category : #'Toplo-Imported-Icons-MaterialDesign'
}

{ #category : #'_code generating' }
ToMaterialDesignIconProvider class >> generateIconMethodsInClass: aIconProviderClass fromSrcDirectoryNamed: aSrcDirName [

	| iconSubDir icons loaded unloadable unloadableCode loadedCode |
	unloadable := #(  ).
	loaded := #(  ).
	iconSubDir := aSrcDirName , '/' , aIconProviderClass _iconType.
	icons := iconSubDir asFileReference entries collect: [ :eachIconDir |
		         eachIconDir basename ].
	icons do: [ :eachIcon |
		{
			ToIconOutlinedStyle.
			ToIconSharpStyle.
			ToIconRoundStyle.
			ToIconTwotoneStyle } do: [ :style |
			| loadable iconSvgPath svgFile svgContents |
			iconSvgPath := iconSubDir , '/' , eachIcon , '/materialicons'
			               , style prefix , '/24px.svg'.
			svgFile := iconSvgPath asFileReference.
			svgFile exists ifTrue: [
				svgContents := iconSvgPath asFileReference readStream contents.
				loadable := ([ BlSvgConverter convertFromString: svgContents ]
					             on: Error
					             do: [  ]) notNil.
				loadable
					ifTrue: [
						| code |
						loaded := loaded copyWith:
							          (style prefix , '_' , eachIcon) asSymbol.
						code := svgContents
							        copyReplaceAll: String lf
							        with: String space
							        asTokens: false.
						aIconProviderClass class
							compile:
							style prefix , '_' , eachIcon , String cr , '^''' , code , ''''
							classified: eachIcon ]
					ifFalse: [
						unloadable := unloadable copyWith:
							              (style prefix , '_' , eachIcon) asSymbol ] ].
			unloadableCode := String streamContents: [ :stream |
				                  unloadable do: [ :symb |
					                  stream nextPutAll: symb printString.
					                  stream nextPutAll: ' ' ] ].
			loadedCode := String streamContents: [ :stream |
				              loaded do: [ :symb |
					              stream nextPutAll: symb printString.
					              stream nextPutAll: ' ' ] ].
			aIconProviderClass class
				compile:
				'_unloadable' , String cr , '^ #( ' , unloadableCode , ' )'
				classified: #'private - loaded and unloadable'.
			aIconProviderClass class
				compile: '_loaded' , String cr , '^ #( ' , loadedCode , ' )'
				classified: #'private - loaded and unloadable' ] ]
]

{ #category : #'_code generating' }
ToMaterialDesignIconProvider class >> generateIconProviderClassesFromSrcDirectotyNamed: aSrcDirName [
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
			            cat := 'Toplo-Core-Theme-MaterialDesign' asSymbol.
			            builder
				            superclass: self;
				            name: newClassName;
				            category: cat ].
		newClass class
			compile:
				'_iconType' , String cr , String cr , String tab , '^ #'''
				, iconType , ''''
			classified: 'generated - icon type'.
		self
			generateIconMethodsInClass: newClass
			fromSrcDirectoryNamed: aSrcDirName ]
]

{ #category : #'_code generating' }
ToMaterialDesignIconProvider class >> listElementWithAllIcons [

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
