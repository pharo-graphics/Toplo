Class {
	#name : #ToTabPaneHeaderElement,
	#superclass : #ToTripletElement,
	#instVars : [
		'tabGroup',
		'alignment'
	],
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #accessing }
ToTabPaneHeaderElement >> alignEnd [

	self alignment: BlElementAlignment end
]

{ #category : #accessing }
ToTabPaneHeaderElement >> alignMiddle [

	self alignment: BlElementAlignment middle
]

{ #category : #accessing }
ToTabPaneHeaderElement >> alignStart [ 

	self alignment: BlElementAlignment start
]

{ #category : #accessing }
ToTabPaneHeaderElement >> alignment [ 

	^ alignment
]

{ #category : #accessing }
ToTabPaneHeaderElement >> alignment: anElementAlignment [ 

	alignment := anElementAlignment.
	self requestConfiguration
]

{ #category : #accessing }
ToTabPaneHeaderElement >> endExtraBuilder: aValuable [

	aValuable value: self endElement
]

{ #category : #initialization }
ToTabPaneHeaderElement >> initialize [

	super initialize.
	self startElement: self newLinearContainer.
	self endElement: self newLinearContainer.
	tabGroup := self newTabGroupElement.
	self middleElement: tabGroup.
	self noAlignment 
]

{ #category : #accessing }
ToTabPaneHeaderElement >> isAlignEnd [

	^ self alignment = BlElementAlignment end
]

{ #category : #accessing }
ToTabPaneHeaderElement >> isAlignMiddle [

	^ self alignment = BlElementAlignment middle
]

{ #category : #accessing }
ToTabPaneHeaderElement >> isAlignStart [

	^ self alignment = BlElementAlignment start
]

{ #category : #'instance creation' }
ToTabPaneHeaderElement >> newTabGroupElement [

	^ ToTabPaneGroupElement new
		  matchParent;
		  yourself
]

{ #category : #configuration }
ToTabPaneHeaderElement >> newToConfiguration [ 

	^ ToTabPaneHeaderConfiguration new
]

{ #category : #accessing }
ToTabPaneHeaderElement >> noAlignment [

	self alignment: BlElementAlignment null
]

{ #category : #layout }
ToTabPaneHeaderElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	| w |
	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	"w := self endContainer measuredBounds inSpace left - self startContainer measuredBounds inSpace right.
	w trace.' ' trace. self trackElement measuredWidth trace. 
	(self trackElement measuredWidth <= w)
		ifTrue: [ 
			' fitContent' traceCr.
			self trackElement parent hFitContent. 
			self trackElement parent parent hFitContent.
			self trackElement parent parent parent hFitContent.
			self trackElement parent parent parent parent hFitContent ]
		ifFalse: [ 
			' matchParent' traceCr.
			self trackElement parent hMatchParent. 
			self trackElement parent parent hMatchParent.
			self trackElement parent parent parent hMatchParent.
			self trackElement parent parent parent parent hMatchParent]"
]

{ #category : #layout }
ToTabPaneHeaderElement >> onMeasure: anExtentMeasurementSpec [

	super onMeasure: anExtentMeasurementSpec.

]

{ #category : #accessing }
ToTabPaneHeaderElement >> startExtraBuilder: aValuable [

	aValuable value: self startElement
]

{ #category : #accessing }
ToTabPaneHeaderElement >> tabGroup [ 

	^ tabGroup
]

{ #category : #accessing }
ToTabPaneHeaderElement >> trackElement [

	^ self middleElement trackElement
]
