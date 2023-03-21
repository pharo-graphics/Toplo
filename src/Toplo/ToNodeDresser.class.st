Class {
	#name : #ToNodeDresser,
	#superclass : #ToMouseHandlingDresser,
	#instVars : [
		'focusGetterHandler',
		'monitor'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #accessing }
ToNodeDresser >> colorProvider [

	^ self theme item 

]

{ #category : #initialization }
ToNodeDresser >> defaultBackground [  

	^ self colorProvider defaultBackgroundColor

]

{ #category : #initialization }
ToNodeDresser >> defaultBorder [  

	^ BlBorder paint: self colorProvider defaultBorderColor width: self defaultBorderWidth

]

{ #category : #initialization }
ToNodeDresser >> defaultBorderWidth [

	^ 1

]

{ #category : #initialization }
ToNodeDresser >> defaultHoveredBackground [  

	^ self colorProvider hoveredBackgroundColor

]

{ #category : #initialization }
ToNodeDresser >> defaultHoveredBorder [

	^ BlBorder paint: self colorProvider hoveredBorderColor

]

{ #category : #initialization }
ToNodeDresser >> defaultInitialBackground [

	^ self colorProvider defaultBackgroundColor
]

{ #category : #initialization }
ToNodeDresser >> defaultInitialBorder [

	^ BlBorder paint: self colorProvider defaultBorderColor.

]

{ #category : #initialization }
ToNodeDresser >> defaultMargin [

	^ (BlInsets
			 top: 2
			 left: 6
			 bottom: 0
			 right: 6)
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> defaultPadding [ 

	^ (BlInsets
			 top: 0
			 left: 0
			 bottom: 0
			 right: 0)
]

{ #category : #accessing }
ToNodeDresser >> hoveredBackground [

	^ self defaultHoveredBackground
]

{ #category : #accessing }
ToNodeDresser >> hoveredBorder [

	^ self defaultHoveredBorder

]

{ #category : #initialization }
ToNodeDresser >> initialize [ 

	super initialize.
	monitor := Monitor new
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	focusGetterHandler := BlEventHandler on: BlClickEvent do: [ :anEvent | anElement holder infiniteElement requestFocus ].
	anElement addEventHandler: focusGetterHandler

]

{ #category : #'events handling' }
ToNodeDresser >> launchClick: aBlock event: anEvent for: anInfinite [

	" click launcher management to allow double click to work with several selected nodes "

	| launcher |
	" do not try double click if ctrl or Cmd or shift is pressed "
	(anEvent modifiers isPrimaryModifier or: [ anEvent modifiers isShift ])
		ifTrue: [
			anInfinite terminateClickLauncher.
			^ aBlock value ].
	
	" Already has a click launcher "
	anInfinite hasClickLauncher ifTrue: [ ^ self ].
	
	" no click launcher for only one selected node "
	anInfinite selectedIndexes size > 1 ifFalse: [ ^ aBlock value ].
	monitor critical: [
		launcher := [
		            (Delay forMilliseconds: 250) wait.
		            aBlock value.
		            anInfinite clickLauncher: nil ]
			            forkAt: Processor highIOPriority
			            named: 'OBlMouseProcessor clickLauncher'.
		anInfinite clickLauncher: launcher ]
]

{ #category : #'events handling' }
ToNodeDresser >> leftClicked: anElement [ 


]

{ #category : #'events handling' }
ToNodeDresser >> leftClicked: anElement event: anEvent [

	self
		launchClick: [ 
			self leftClicked: anElement.
			anElement holder announce: (ToClickOnNodeAnnouncement new
					 holder: anElement holder;
					 event: anEvent;
					 yourself) ]
		event: anEvent
		for: anElement holder infiniteElement
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement hMatchParent.
	anElement geometry: BlRectangleGeometry new.
	anElement padding: self defaultPadding.
	anElement margin: self defaultMargin.
	anElement border: self defaultInitialBorder.
	anElement background: self defaultInitialBackground
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: focusGetterHandler

]
