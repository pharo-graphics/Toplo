Class {
	#name : #ToBasicWindowElement,
	#superclass : #ToElement,
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToBasicWindowElement >> close [

	self removeFromParent
]

{ #category : #initialization }
ToBasicWindowElement >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 1000)
]

{ #category : #initialization }
ToBasicWindowElement >> defaultLayout [

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToBasicWindowElement >> initialize [

	super initialize.
	self
		elevation: self defaultElevation;
		layout: self defaultLayout;
		fitContent.
	self constraintsDo: [ :c | c ignoreByLayout ]
]

{ #category : #skin }
ToBasicWindowElement >> installRawStyle [

	super installRawStyle.
	self geometry: (BlRoundedRectangleGeometry cornerRadius:
			 (self valueOfTokenNamed: #'border-radius-SM')).
	self border: (self valueOfTokenNamed: #'color-border').
	self background: (self valueOfTokenNamed: #'color-bg-container').
	self outskirts: BlOutskirts outside 
]

{ #category : #'api - displaying' }
ToBasicWindowElement >> isClosed [

	^ self isOpened not
]

{ #category : #'api - displaying' }
ToBasicWindowElement >> isOpened [

	^ self hasParent
]

{ #category : #accessing }
ToBasicWindowElement >> root [
	"Return my current root element.
	root can not be nil"
	
	^ self
]

{ #category : #'api - displaying' }
ToBasicWindowElement >> toFront [

	self elevation: self defaultElevation
]

{ #category : #enumerating }
ToBasicWindowElement >> withAllSubwindowsDo: aBlock [

	aBlock value: self
]
