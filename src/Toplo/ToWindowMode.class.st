Class {
	#name : #ToWindowMode,
	#superclass : #Object,
	#instVars : [
		'manager'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToWindowMode >> arrangeWindow: aWindow onEvent: anEvent [

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

{ #category : #'api - hooks' }
ToWindowMode >> onInstalledIn: aManager [

	manager := aManager
]

{ #category : #'api - hooks' }
ToWindowMode >> onUninstalledIn: aManager [

	manager := nil
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
