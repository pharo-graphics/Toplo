Class {
	#name : #ToWindowMode,
	#superclass : #Object,
	#instVars : [
		'manager'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToWindowMode >> anchorElement [

	^ manager anchorElement
]

{ #category : #accessing }
ToWindowMode >> element [

	self deprecated: 'Use #anchorElement instead' transformWith: '`@rcvr element'->'`@rcvr anchorElement'.
	^ self anchorElement
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

{ #category : #'api - hooks' }
ToWindowMode >> onInstalledIn: aManager [

	manager := aManager
]

{ #category : #'api - displaying' }
ToWindowMode >> onMeasure: anExtentMeasurementSpec element: aWindow onEvent: anEvent [

	self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToWindowMode >> onUninstalledIn: aManager [

	manager := nil
]

{ #category : #'api - displaying' }
ToWindowMode >> positionElement: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [

	self subclassResponsibility 
]

{ #category : #'window handling' }
ToWindowMode >> startWindow: aWindow [

	self subclassResponsibility 
]

{ #category : #'window handling' }
ToWindowMode >> stopWindow: aWindow [

	self subclassResponsibility 
]

{ #category : #accessing }
ToWindowMode >> windowClass [ 

	^ self subclassResponsibility 
]
