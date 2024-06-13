Class {
	#name : #ToListNodeEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #layout }
ToListNodeEventHandler >> constraintNode: aNode [

	| nodeManager |
	aNode isFake ifTrue: [ ^ self ].
	nodeManager := aNode holder nodeManager.
	nodeManager constraintNode: aNode
]

{ #category : #'api - accessing' }
ToListNodeEventHandler >> eventsToHandle [

	^ {
		  ToMainLayoutDirectionChangedEvent.
		  ToMainLayoutOrientationChangedEvent.
		  ToMainResizerChangedEvent }
]

{ #category : #layout }
ToListNodeEventHandler >> mainLayoutDirectionChangedEvent: anEvent [
	self constraintNode: anEvent currentTarget

	
]

{ #category : #layout }
ToListNodeEventHandler >> mainLayoutOrientationChangedEvent: anEvent [
	self constraintNode: anEvent currentTarget

	
]

{ #category : #layout }
ToListNodeEventHandler >> mainResizerChangedEvent: anEvent [
	self constraintNode: anEvent currentTarget

	
]
