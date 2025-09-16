Class {
	#name : #ToEdgePane,
	#superclass : #ToPane,
	#traits : 'TToAnchoredWindowElement',
	#classTraits : 'TToAnchoredWindowElement classTrait',
	#instVars : [
		'breadth'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #configuration }
ToEdgePane >> applyConfiguration [ 

	super applyConfiguration.
	self width: breadth 
]

{ #category : #accessing }
ToEdgePane >> breadth [

	^ breadth
]

{ #category : #accessing }
ToEdgePane >> breadth: aNumber [

	breadth := aNumber.
	self requestConfiguration
]

{ #category : #initialization }
ToEdgePane >> defaultBreadth [

	^ 200
]

{ #category : #initialization }
ToEdgePane >> initialize [

	super initialize.
	self breadth: self defaultBreadth.
	self constraintsDo: [ :c | c ignoreByLayout.
		c anchors add: (c anchors topLeftAnchor on: c anchors parent topLeftAnchor).
		c anchors add: (c anchors heightAnchor on: c anchors parent heightAnchor) ]
]

{ #category : #'instance creation' }
ToEdgePane >> newRawSkin [ 

	^ ToEdgePaneSkin new
]

{ #category : #layout }
ToEdgePane >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self checkLayoutStepOnLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #layout }
ToEdgePane >> onMeasure: anExtentMeasurementSpec [

	self onMeasure: anExtentMeasurementSpec onEvent: self lastPopupEvent.
	super onMeasure: anExtentMeasurementSpec.


]

{ #category : #'t - anchored window element - displaying' }
ToEdgePane >> open [

	self start.
	self localTheme ifNil: [
		self localTheme: self anchorElement lookupTheme ].
	popupTimestamp := self space time now.
	self dispatchOpenedEvent
]
