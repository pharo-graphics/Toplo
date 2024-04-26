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
ToImportedIconProvider class >> listElementWithAllIconsInProviderClass: aProviderClass [

	| l icProvider styles |
	icProvider := aProviderClass new.
	l := ToListElement new.
	l withRowNumbers.
	l selectionMode beneathOption: ToListSelectionOption none.
	l selectionMode overOption: ToListSelectionOption grouped.
	l secondarySelectionMode beneathOption: ToListSelectionOption none.
	l secondarySelectionMode overOption: ToListSelectionOption separate.

	styles := ToIconStyle allSubclasses asArray sort: [ :a :b |
		          a name < b name ].
	styles do: [ :style |
		| s |
		s := ('_' , style prefix , '_loaded') asSymbol.
		(icProvider class respondsTo: s) ifTrue: [
			| iconNames |
			iconNames := (icProvider class perform: s) sort.
			l dataAccessor addAll: (iconNames collect: [ :n | n -> style ]) ] ].

	l nodeBuilder: [ :node :holder |
		| styleLab stylePane iclab iclabPane imPane iconStyle iconName |
		iconStyle := holder dataItem value.
		iconName := holder dataItem key.
		node layout: BlLinearLayout horizontal.
		iclabPane := ToPane new layout: BlFrameLayout new.
		iclabPane vFitContent.
		iclabPane width: 150.
		stylePane := ToPane new layout: BlFrameLayout new.
		stylePane vFitContent.
		stylePane width: 60.
		iclab := ToLabel text: iconName.
		iclab constraintsDo: [ :c | c frame vertical alignCenter ].
		iclabPane addChild: iclab.
		styleLab := ToLabel text: iconStyle prefix.
		styleLab constraintsDo: [ :c | c frame vertical alignCenter ].
		stylePane addChild: styleLab.
		imPane := ToPane new layout: BlFrameLayout new.
		imPane fitContent.
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
