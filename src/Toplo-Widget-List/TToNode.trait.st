Trait {
	#name : 'TToNode',
	#category : 'Toplo-Widget-List-node',
	#package : 'Toplo-Widget-List',
	#tag : 'node'
}

{ #category : 't - list node - initialization' }
TToNode >> colorProvider [

	^ self theme item 

]

{ #category : 't - list node - initialization' }
TToNode >> defaultBackground [  

	^ self colorProvider defaultBackgroundColor
]

{ #category : 't - list node - initialization' }
TToNode >> defaultBorder [

	^ BlBorder
		  paint: self colorProvider defaultBorderColor
		  width: self defaultBorderWidth
]

{ #category : 't - list node - initialization' }
TToNode >> defaultBorderWidth [

	^ 1

]

{ #category : 't - list node - initialization' }
TToNode >> defaultEventHandler [

	^ self explicitRequirement 
]

{ #category : 't - list node - initialization' }
TToNode >> defaultHoveredBackground [  

	^ self colorProvider hoveredBackgroundColor

]

{ #category : 't - list node - initialization' }
TToNode >> defaultHoveredBorder [

	^ BlBorder paint: self colorProvider hoveredBorderColor

]

{ #category : 't - list node - initialization' }
TToNode >> defaultInitialBackground [

	^ self colorProvider defaultBackgroundColor
]

{ #category : 't - list node - initialization' }
TToNode >> defaultInitialBorder [

	^ BlBorder paint: self colorProvider defaultBorderColor.

]

{ #category : 't - list node - initialization' }
TToNode >> defaultMargin [

	^ BlInsets all: 0
]

{ #category : 't - list node - initialization' }
TToNode >> defaultPadding [

	^ BlInsets all: 2
]

{ #category : 't - list node - initialization' }
TToNode >> initializeListNode [

	self hMatchParent.
	self geometry: self defaultGeometry.
	self padding: self defaultPadding.
	self margin: self defaultMargin.
	self border: self defaultInitialBorder.
	self background: self defaultInitialBackground.
	self addEventHandler: self defaultEventHandler.
]
