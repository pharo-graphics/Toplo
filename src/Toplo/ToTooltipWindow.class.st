Class {
	#name : #ToTooltipWindow,
	#superclass : #ToPopupWindow,
	#instVars : [
		'#content => ObservableSlot',
		'#label'
	],
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #accessing }
ToTooltipWindow >> content [

	^ content
]

{ #category : #accessing }
ToTooltipWindow >> content: aText [

	content := aText
]

{ #category : #accessing }
ToTooltipWindow >> contentString: aString [

	self content: aString asRopedText
]

{ #category : #initialization }
ToTooltipWindow >> defaulPositioningHook [

	^ [ :w :event | event position x @ (w widget localPointToGlobal: 0 @ w widget height) y + self vgap ]
]

{ #category : #initialization }
ToTooltipWindow >> defaultLabel [

	^ ToLabel new
		  beMultiLine;
		  text: self content;
		  preventMouseEvents;
		  yourself
]

{ #category : #initialization }
ToTooltipWindow >> defaultWidgetEventHandler [ 

	^ ToWidgetWithTooltipEventHandler new
]

{ #category : #initialization }
ToTooltipWindow >> initialize [

	super initialize.
		
	self elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	self whenContentChangedDo: [ self label text: self content ].
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
	self border: (BlBorder paint: (Color gray alpha: 0.4)).
	self background: (Color yellow alpha: 0.2).
	self padding: (BlInsets all: 4).
	self label margin: (BlInsets all: 4).
	self fitContent.
	self label constraintsDo: [ :c | 
		c linear vertical alignCenter.
		c linear horizontal alignCenter ].
	self addEventHandler: ToTooltipWindowEventHandler new

]

{ #category : #accessing }
ToTooltipWindow >> label [

	^ label ifNil: [ 	self label: self defaultLabel. label ]
]

{ #category : #accessing }
ToTooltipWindow >> label: aLabel [

	label ifNotNil: [ label removeFromParent ].
	label := aLabel.
	self root addChild: label.

]

{ #category : #initialization }
ToTooltipWindow >> vgap [

	^ 5
]

{ #category : #'api - properties change hook' }
ToTooltipWindow >> whenContentChangedDo: aBlock [
	"Inform when content property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #content whenChangedDo: aBlock
]
