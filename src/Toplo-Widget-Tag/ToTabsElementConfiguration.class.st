Class {
	#name : #ToTabsElementConfiguration,
	#superclass : #ToTripletElementConfiguration,
	#instVars : [
		'nodeMenu',
		'endExtraContainer',
		'atStartSide'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #hook }
ToTabsElementConfiguration >> applyOn: aTabsElement [

	super applyOn: aTabsElement.
	
	aTabsElement itemBar horizontal: aTabsElement isHorizontal.
	aTabsElement itemBar atStartSide: atStartSide.
	aTabsElement itemBar matchParent.
	
	aTabsElement isHFitContent
		ifTrue: [
			middleContainer constraintsDo: [ :c | c horizontal fitContent ].
			aTabsElement itemBar hFitContent ]
		ifFalse: [
			middleContainer constraintsDo: [ :c | c horizontal matchParent ].
			aTabsElement itemBar hMatchParent ].

	aTabsElement isVFitContent
		ifTrue: [
			middleContainer constraintsDo: [ :c | c vertical fitContent ].
			aTabsElement itemBar vFitContent ]
		ifFalse: [
			middleContainer constraintsDo: [ :c | c vertical matchParent ].
			aTabsElement itemBar vMatchParent ].

	aTabsElement isHorizontal
		ifTrue: [ endElement layout beHorizontal ]
		ifFalse: [ endElement layout beVertical ].

	aTabsElement checkNodeMenu
]

{ #category : #accessing }
ToTabsElementConfiguration >> atStartSide [

	^ atStartSide
]

{ #category : #accessing }
ToTabsElementConfiguration >> atStartSide: aBoolean [

	atStartSide := aBoolean
]

{ #category : #accessing }
ToTabsElementConfiguration >> endExtraContainer [

	^ endExtraContainer
]

{ #category : #initialization }
ToTabsElementConfiguration >> initialize [ 

	super initialize.
	atStartSide := true.

]

{ #category : #accessing }
ToTabsElementConfiguration >> nodeMenu [ 

	^ nodeMenu
]

{ #category : #hook }
ToTabsElementConfiguration >> onInstalledIn: aTabsElement [

	| menuImage container |
	super onInstalledIn: aTabsElement.

	menuImage := ToMaterialDesignIconProvider innerImageNamed:
		             'outlined_menu'.
	nodeMenu := ToMenu new iconImage: menuImage.
	nodeMenu icon size: 20 asPoint.
	nodeMenu builder: aTabsElement defaultNodeMenuBuilder.
	nodeMenu visibility: BlVisibility gone.

	self startElement: aTabsElement newBaseContainer in: aTabsElement.

	container := aTabsElement newBaseContainer.
	container layout: BlLinearLayout new.
	endExtraContainer := aTabsElement newBaseContainer.
	container addChild: nodeMenu.
	container addChild: endExtraContainer.
	self endElement: container in: aTabsElement.
	endContainer layout: BlLinearLayout new.
	nodeMenu constraintsDo: [ :c |
		c linear horizontal alignCenter.
		c linear vertical alignCenter ].
	endExtraContainer constraintsDo: [ :c |
		c linear horizontal alignCenter.
		c linear vertical alignCenter ]
]
