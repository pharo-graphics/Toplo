Class {
	#name : 'ToNullElementLook',
	#superclass : 'ToAbstractLook',
	#category : 'Toplo-Theme-Core',
	#package : 'Toplo-Theme',
	#tag : 'Core'
}

{ #category : 'private event handling' }
ToNullElementLook >> elementLookEvent: anEvent [
]

{ #category : 'api - accessing' }
ToNullElementLook >> findLookUpdaterForPropertyNamed: aName [

	^ nil
]

{ #category : 'testing' }
ToNullElementLook >> isNull [

	^ true
]

{ #category : 'removing' }
ToNullElementLook >> removeLook: aLook previous: previousLook [

	
]
