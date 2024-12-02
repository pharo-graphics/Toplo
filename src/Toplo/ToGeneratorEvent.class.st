Class {
	#name : #ToGeneratorEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent',
		'emitter'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #accessing }
ToGeneratorEvent >> emitter [

	^ emitter
]

{ #category : #accessing }
ToGeneratorEvent >> emitter: anObject [

	emitter := anObject
]

{ #category : #accessing }
ToGeneratorEvent >> modifiers [

	^ sourceEvent modifiers
]

{ #category : #accessing }
ToGeneratorEvent >> position [

	^ sourceEvent position
]

{ #category : #accessing }
ToGeneratorEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToGeneratorEvent >> sourceEvent: anObject [

	sourceEvent := anObject
]

{ #category : #accessing }
ToGeneratorEvent >> sourceHandler [

	self
		deprecated: 'Use #emitter'
		transformWith:
		'`@rcvr sourceHandler' -> '`@rcvr emitter'.
	^ emitter
]

{ #category : #accessing }
ToGeneratorEvent >> sourceHandler: anObject [

	self
		deprecated: 'Use #emitter:'
		transformWith:
		'`@rcvr sourceHandler: `@arg' -> '`@rcvr emitter: `@arg'.
	emitter := anObject
]
