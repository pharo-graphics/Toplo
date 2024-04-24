Class {
	#name : #ToGeneratedIconProvider,
	#superclass : #ToIconProvider,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'loaded and unloadable' }
ToGeneratedIconProvider class >> _loaded [

	^ #(  )
]

{ #category : #'loaded and unloadable' }
ToGeneratedIconProvider class >> _unloadable [

	^ #(  )
]

{ #category : #'code generating' }
ToGeneratedIconProvider class >> addIconMethodsInClass: aClass fromFlatDir: aString [

	self
		addMethodsInClass: aClass
		withIcons: (aString asFileReference entries collect: [ :each |
				 (self iconNameFromFileName: each basename)
				 -> ((self categoryNameFromFileName: each basename)
					  -> each readStream contents) ])
]

{ #category : #'private - code generating' }
ToGeneratedIconProvider class >> addMethodsInClass: aClass withIcons: aCollection [

	| unloadable loaded unloadableCode loadedCode |
	unloadable := #(  ).
	loaded := #(  ).
	aCollection do: [ :assoc |
		assoc ifNotNil: [
			| loadable |
			loadable := ([ BlSvgConverter convertFromString: assoc value value ]
				             on: Error
				             do: [  ]) notNil.
			loadable
				ifTrue: [
					loaded := loaded copyWith: assoc key asSymbol.
					aClass class
						compile:
						assoc key , 'Src' , String cr , '^''' , assoc value value , ''''
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
		compile: '_unloadable' , String cr , '^ #( ' , unloadableCode , ' )'
		classified: #'private - loaded and unloadable'.
	aClass class
		compile: '_loaded' , String cr , '^ #( ' , loadedCode , ' )'
		classified: #'private - loaded and unloadable'
]

{ #category : #'private - code generating' }
ToGeneratedIconProvider class >> categoryNameFromFileName: aFileName [

	^ ($- split: ($. split: aFileName) first) first asLowercase
]

{ #category : #'private - code generating' }
ToGeneratedIconProvider class >> iconNameFromFileName: aFileName [

	^ (($. split: aFileName) first replaceAll: $- with: Character space)
		  asCamelCase asValidSelector
]

{ #category : #inspecting }
ToGeneratedIconProvider class >> listElementWithAllIcons [

	| l icProvider |
	icProvider := ToAntOutlinedSvgIconProvider new.
	l := ToListElement new.
	l withRowNumbers.
	l selectionMode beneathOption: ToListSelectionOption none.
	l selectionMode overOption: ToListSelectionOption grouped.
	l dataAccessor addAll: icProvider class _loaded.
	l nodeBuilder: [ :node :holder |
		| lab labPane imPane |
		node layout: BlLinearLayout horizontal.
		labPane := ToPane new layout: BlFrameLayout new.
		labPane withNullSkin.
		labPane vFitContent.
		labPane width: 150.
		lab := ToLabel text: holder dataItem.
		lab constraintsDo: [ :c | c frame vertical alignCenter ].
		labPane addChild: lab.
		imPane := ToPane new layout: BlFrameLayout new.
		imPane fitContent.
		imPane addChild:
			((icProvider iconNamed: holder dataItem ifAbsent: [  ])
				 size: 24 asPoint;
				 yourself).
		node addChildren: {
				labPane.
				imPane }.
		node childrenDo: [ :child |
			child constraintsDo: [ :c | c linear vertical alignCenter ] ] ].
	^ l
]

{ #category : #accessing }
ToGeneratedIconProvider >> iconNamed: aName [

	^ self iconNamed: aName ifAbsent: [  ]
]

{ #category : #accessing }
ToGeneratedIconProvider >> iconNamed: aName ifAbsent: aBlock [

	^ [ ToImage inner: (self class perform: (aName , 'Src') asSymbol) ]
		  on: Error
		  do: [ :err | aBlock value ]
]
