Class {
	#name : #ToCommandManager,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'operator',
		'commandApplier',
		'eventDispatcher'
	],
	#category : #'Toplo-Widget-List-Command-Support-not-used'
}

{ #category : #accessing }
ToCommandManager >> commandApplier: aCommandApplier [

	commandApplier := aCommandApplier 
]

{ #category : #'command event dispatching' }
ToCommandManager >> dispatchCommandAdded: aCommand [

	self dispatchEvent: (ToElementCommandAddedEvent new
			 command: aCommand;
			 yourself)
]

{ #category : #'event management accessing' }
ToCommandManager >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
ToCommandManager >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : #accessing }
ToCommandManager >> operator [

	^ operator
]

{ #category : #accessing }
ToCommandManager >> operator: anOperator [

	operator := anOperator
]
