Class {
	#name : #ToBasicWindowElement,
	#superclass : #ToElement,
	#category : #'Toplo-Core-Window'
}

{ #category : #enumerating }
ToBasicWindowElement >> allSubwindowsDo: aBlock [
]

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

{ #category : #'api - displaying' }
ToBasicWindowElement >> isClosed [

	^ self isOpened not
]

{ #category : #'api - displaying' }
ToBasicWindowElement >> isOpened [

	^ self hasParent
]

{ #category : #skin }
ToBasicWindowElement >> newRawSkin [

	^ ToBasicWindowElementSkin new
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
