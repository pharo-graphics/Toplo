Class {
	#name : #ToDirectCommandManager,
	#superclass : #ToCommandManager,
	#category : #'Toplo-Widget-List-Command-Support-not-used'
}

{ #category : #'command application' }
ToDirectCommandManager >> applyCommand: aCommand [

	commandApplier applyCommand: aCommand
]

{ #category : #'command event dispatching' }
ToDirectCommandManager >> dispatchCommandAdded: aCommand [

	self applyCommand: aCommand
]

{ #category : #initialization }
ToDirectCommandManager >> initialize [ 

	super initialize.
	self addEventHandler: ToDirectCommandManagerEventHandler new
	
]
