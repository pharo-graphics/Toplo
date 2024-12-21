Class {
	#name : #ToWindowMode,
	#superclass : #Object,
	#instVars : [
		'manager'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToWindowMode >> arrangeWindowOnEvent: anEvent [

	self subclassResponsibility 
]

{ #category : #testing }
ToWindowMode >> isInline [ 

	^ false
]

{ #category : #accessing }
ToWindowMode >> manager: aManager [

	manager := aManager
]

{ #category : #'instance creation' }
ToWindowMode >> newWindow [

	^ self windowClass new
		  manager: manager;
		  yourself
]

{ #category : #'window handling' }
ToWindowMode >> showWindow: aWindow [

	self subclassResponsibility 
]

{ #category : #accessing }
ToWindowMode >> windowClass [ 

	^ self subclassResponsibility 
]
