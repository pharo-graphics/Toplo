Class {
	#name : #ToImportedIconProvider,
	#superclass : #ToIconProvider,
	#category : #'Toplo-Core-Theme'
}

{ #category : #accessing }
ToImportedIconProvider class >> iconNamed: aName [

	^ self iconNamed: aName ifAbsent: [  ]
]

{ #category : #accessing }
ToImportedIconProvider class >> iconNamed: aName ifAbsent: aBlock [

	^ [
	  ToImage inner:
		  (self perform: aName asSymbol) ]
		  on: Error
		  do: [ :err | aBlock value ]
]

{ #category : #'_private - utilities' }
ToImportedIconProvider class >> listElementWithAllIcons [
	"
	ToMaterialDesignIconProvider listElementWithAllIcons openInSpace.
	ToAntDesignIconProvider listElementWithAllIcons openInSpace.
	"

	| l icProvider styles assocs |
	icProvider := self new.
	l := ToListElement new.
	l vertical: true.
	l withRowNumbers.

	l addEventHandler: (BlEventHandler
			 on: ToListStrongSelectionEvent
			 do: [ :event |
				 (event indexes collect: [ :idx | l dataAccessor at: idx]) traceCr ]).


	styles := ToIconStyle allSubclasses asArray sort: [ :a :b |
		          a name < b name ].
	
	assocs := Array streamContents: [ :stream |
		          styles do: [ :style |
			          | s |
			          s := ('_' , style prefix , '_loaded') asSymbol.
			          (icProvider class respondsTo: s) ifTrue: [
				          | iconNames |
				          iconNames := (icProvider class perform: s) sort.
				          stream nextPutAll:
					          (iconNames collect: [ :n | n -> style ]) ] ] ].

	l dataAccessor addAll: assocs.

	l nodeBuilder: [ :node :dataItem :holder |
		| styleLab stylePane iclab iclabPane imPane iconStyle iconName |
		iconStyle := dataItem value.
		iconName := dataItem key.
		node layout: BlLinearLayout horizontal.
		iclabPane := ToElement new layout: BlFrameLayout new.
		iclabPane vFitContent.
		iclabPane width: 150.
		stylePane := ToElement new layout: BlFrameLayout new.
		stylePane vFitContent.
		stylePane width: 60.
		iclab := ToLabel text: iconName.
		iclab constraintsDo: [ :c | c frame vertical alignCenter ].
		iclabPane addChild: iclab.
		styleLab := ToLabel text: iconStyle prefix.
		styleLab constraintsDo: [ :c | c frame vertical alignCenter ].
		stylePane addChild: styleLab.
		imPane := ToElement new layout: BlFrameLayout new.
		imPane fitContent.
		imPane withNullSkin.
		imPane background: (Color veryVeryLightGray).
		imPane addChild:
			((iconStyle iconNamed: iconName inProvider: icProvider)
				 size: 24 asPoint;
				 yourself).
		node addChildren: {
				stylePane.
				iclabPane.
				imPane }.
		node childrenDo: [ :child |
			child constraintsDo: [ :c | c linear vertical alignCenter ] ] ].

	^ l
]

{ #category : #accessing }
ToImportedIconProvider >> iconNamed: aName [ 
	^ self class iconNamed: aName 
]

{ #category : #accessing }
ToImportedIconProvider >> iconNamed: aName ifAbsent: aBlock [ 
	^ self class iconNamed: aName ifAbsent: aBlock 
]
