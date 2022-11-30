Class {
	#name : #ToTooltip,
	#superclass : #ToPopupWindow,
	#instVars : [
		'#content => ObservableSlot',
		'#label',
		'#widgetWithTooltipEventHandler'
	],
	#category : #'Toplo-Widget-Tooltip'
}

{ #category : #accessing }
ToTooltip >> content [

	^ content
]

{ #category : #accessing }
ToTooltip >> content: aText [

	content := aText
]

{ #category : #accessing }
ToTooltip >> contentString: aString [

	self content: aString asRopedText
]

{ #category : #'t - accessing - dresser' }
ToTooltip >> defaultDresser [

	^ ToTooltipDresser new

]

{ #category : #initialization }
ToTooltip >> defaultLabel [

	^ ToLabel new
		  beMultiLine;
		  text: self content;
		  preventMouseEvents;
		  yourself
]

{ #category : #initialization }
ToTooltip >> initialize [

	self class initializeSlots: self.
	super initialize.
	self elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	self label: self defaultLabel.
	self whenContentChangedDo: [ self label text: self content ].
	self dresser: self defaultDresser.
	self whenWidgetChangedDo: [ :newWidget :oldWidget | 
		self uninstalledFrom: oldWidget.
		self installedIn: newWidget ]
]

{ #category : #initialization }
ToTooltip >> installedIn: aWidget [

	aWidget ifNil: [ ^ self ].
	widgetWithTooltipEventHandler := ToWidgetWithTooltipEventHandler new.
	aWidget addEventFilter: widgetWithTooltipEventHandler 
]

{ #category : #accessing }
ToTooltip >> label [

	^ label
]

{ #category : #accessing }
ToTooltip >> label: aLabel [

	label ifNotNil: [ label removeFromParent ].
	label := aLabel.
	self addChild: label.

]

{ #category : #initialization }
ToTooltip >> uninstalledFrom: aWidget [

	aWidget ifNil: [ ^ self ].
	aWidget removeEventFilter: widgetWithTooltipEventHandler.
	widgetWithTooltipEventHandler := nil
]

{ #category : #'api - properties change hook' }
ToTooltip >> whenContentChangedDo: aBlock [
	"Inform when content property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #content whenChangedDo: aBlock
]
