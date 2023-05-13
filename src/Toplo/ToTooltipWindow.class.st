Class {
	#name : #ToTooltipWindow,
	#superclass : #ToPopupWindow,
	#instVars : [
		'#content => ObservableSlot',
		'#label',
		'#widgetWithTooltipEventHandler'
	],
	#category : #'Toplo-Widget-Tooltip'
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

{ #category : #'t - accessing - dresser' }
ToTooltipWindow >> defaultDresser [

	^ ToTooltipWindowDresser new

]

{ #category : #initialization }
ToTooltipWindow >> defaultHook [

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
ToTooltipWindow >> initialize [

	super initialize.
		
	self elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	self whenContentChangedDo: [ self label text: self content ]
]

{ #category : #initialization }
ToTooltipWindow >> installedInWidget: aWidget [

	super installedInWidget: aWidget.
	aWidget ifNil: [ ^ self ].
	widgetWithTooltipEventHandler := ToWidgetWithTooltipEventHandler new widget: aWidget.
	aWidget addEventFilter: widgetWithTooltipEventHandler
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
ToTooltipWindow >> uninstalledFromWidget: aWidget [

	super uninstalledFromWidget: aWidget.
	aWidget ifNil: [ ^ self ].
	aWidget removeEventFilter: widgetWithTooltipEventHandler.
	widgetWithTooltipEventHandler := nil
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
