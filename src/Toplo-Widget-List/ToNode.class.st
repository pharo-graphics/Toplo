Class {
	#name : 'ToNode',
	#superclass : 'ToElement',
	#traits : 'TToClickable + TToOrientable',
	#classTraits : 'TToClickable classTrait + TToOrientable classTrait',
	#category : 'Toplo-Widget-List-node',
	#package : 'Toplo-Widget-List',
	#tag : 'node'
}

{ #category : 'initialization' }
ToNode >> colorProvider [

	^ self theme item 

]

{ #category : 'initialization' }
ToNode >> defaultEventHandler [

	^ ToNodeEventHandler new
]

{ #category : 'initialization' }
ToNode >> defaultHoveredBackground [  

	^ self colorProvider hoveredBackgroundColor

]

{ #category : 'initialization' }
ToNode >> defaultHoveredBorder [

	^ BlBorder paint: self colorProvider hoveredBorderColor

]

{ #category : 'initialization' }
ToNode >> defaultInitialBackground [

	^ self colorProvider defaultBackgroundColor
]

{ #category : 'initialization' }
ToNode >> defaultInitialBorder [

	^ BlBorder paint: self colorProvider defaultBorderColor.

]

{ #category : 'initialization' }
ToNode >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : 'initialization' }
ToNode >> defaultMargin [

	^ BlInsets empty
]

{ #category : 'initialization' }
ToNode >> defaultPadding [

	^ BlInsets empty
]

{ #category : 'initialization' }
ToNode >> initialize [

	super initialize.
	self
		hMatchParent;
		vFitContent;
		geometry: self defaultGeometry;
		padding: self defaultPadding;
		margin: self defaultMargin;
		border: self defaultInitialBorder;
		background: self defaultInitialBackground;
		addEventHandler: self defaultEventHandler
]

{ #category : 't - orientable - accessing' }
ToNode >> layoutStrategy [

	^ self layout

	
]
