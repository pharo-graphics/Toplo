Class {
	#name : #ToNodeDresser,
	#superclass : #ToMouseHandlingDresser,
	#instVars : [
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

	^ BlInsets all: 0
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> defaultPadding [

	^ BlInsets all: 2
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

]

{ #category : #'events handling' }
ToNodeDresser >> launchClick: aBlock event: anEvent for: anElement [

	" click launcher management to allow double click to work with several selected nodes "

	| launcher infinite |
	
	infinite := anElement holder infiniteElement.
	
	infinite hasOpenedContextMenu ifTrue: [ infinite terminateClickLauncher. ^ self ].
	
	" do not try double click if ctrl or Cmd or shift is pressed "
	(anElement holder isSelected not or: [anEvent modifiers isPrimaryModifier or: [ anEvent modifiers isShift ]])
		ifTrue: [
			infinite terminateClickLauncher.
			^ aBlock value ].
		
	
	" Already has a click launcher "
	infinite hasClickLauncher ifTrue: [ ^ self ].
	
	" no click launcher for only one selected node "
	infinite primarySelectionIndexes size > 1 ifFalse: [ ^ aBlock value ].
	monitor critical: [
		launcher := [
		            (Delay forMilliseconds: 250) wait.
		            aBlock value.
		            infinite clickLauncher: nil ]
			            forkAt: Processor highIOPriority
			            named: 'ToNodeDresser clickLauncher'.
		infinite clickLauncher: launcher ]
]

{ #category : #'events handling' }
ToNodeDresser >> leftClicked: anElement event: anEvent [

	self
		launchClick: [ 
			anElement holder announce: (ToClickOnNodeAnnouncement new
					 holder: anElement holder;
					 event: anEvent;
					 yourself) ]
		event: anEvent
		for: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement hMatchParent.
	anElement geometry: BlRectangleGeometry new.
	anElement padding: self defaultPadding.
	anElement margin: self defaultMargin.
	anElement border: self defaultInitialBorder.
	anElement background: self defaultInitialBackground.
	anElement clipChildren: true.
	anElement outskirts: BlOutskirts inside
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
]
