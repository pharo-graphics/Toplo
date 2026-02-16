Class {
	#name : #ToCircularMenuListSecondarySelectionElement,
	#superclass : #ToAnnulusSectorElement,
	#traits : 'TToListSelectionElement',
	#classTraits : 'TToListSelectionElement classTrait',
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #'t - list selection element - private' }
ToCircularMenuListSecondarySelectionElement >> boundsInListElement: aListElement [

	| first last startBnds endBnds corner containers |
	containers := self nodeContainers.
	first := containers first.
	last := containers last.
	startBnds := (first measuredBounds inSpace inChild:
		              aListElement innerElement) bounds.
	endBnds := first = last
		           ifTrue: [ startBnds ]
		           ifFalse: [
				           (last measuredBounds inSpace inChild:
					            aListElement innerElement) bounds ].
	corner := endBnds corner.

	^ Rectangle
		  origin: (self
				   positionFrom:
				   startBnds origin + aListElement innerElement position
				   in: aListElement)
		  extent:
		  (self sizeFrom: corner - startBnds origin in: aListElement)
]

{ #category : #initialization }
ToCircularMenuListSecondarySelectionElement >> initialize [ 

	super initialize.
	self initializeAsListSelectionElement
]

{ #category : #'instance creation' }
ToCircularMenuListSecondarySelectionElement >> newRawSkin [

	^ ToScriptableSkin new
		  onInstallSkinEvent: [ :e :evt |
			  e background: (e valueOfTokenNamed: #'color-secondary-selection') ];
		  yourself
]

{ #category : #'t - list selection element - accessing' }
ToCircularMenuListSecondarySelectionElement >> nodeContainers: aNodeContainerArray listElement: aListElement [

	| bnds |
	nodeContainers := aNodeContainerArray.
	listElement := aListElement.
	bnds := self precomputedBoundsIn: aListElement.
	self position: bnds origin.
	self extent: bnds extent.
	self startAngle: self nodeContainer startAngle.
	self endAngle: self nodeContainer endAngle.
	self innerRadius: self nodeContainer innerRadius.
	self outerRadius: self nodeContainer outerRadius
]
