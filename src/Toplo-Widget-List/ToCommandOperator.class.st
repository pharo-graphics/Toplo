Class {
	#name : #ToCommandOperator,
	#superclass : #Object,
	#instVars : [
		'target',
		'command'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'applied command handling' }
ToCommandOperator >> actionCommand: aCommand [

	aCommand action cull: self target
]

{ #category : #accessing }
ToCommandOperator >> addCommand: aCommand [

	command ifNil: [ command := aCommand ] ifNotNil: [
		| tail |
		tail := command.
		[ tail next isNil ] whileFalse: [ tail := tail next ].
		tail next: aCommand ].

	self target dispatchEvent: (ToCommandAddedEvent new
			 command: command;
			 commandTarget: self;
			 yourself)
]

{ #category : #'command application' }
ToCommandOperator >> apply [

	command ifNil: [ ^ self ].
	command applyOn: self.

]

{ #category : #accessing }
ToCommandOperator >> command [

	^ command
]

{ #category : #accessing }
ToCommandOperator >> command: anObject [

	command := anObject
]

{ #category : #'api - hooks' }
ToCommandOperator >> onInstalledIn: anEventTarget [

	self target: anEventTarget
]

{ #category : #'api - hooks' }
ToCommandOperator >> onUninstalledIn: anEventTarget [

	self target: nil.

	

]

{ #category : #accessing }
ToCommandOperator >> target [

	^ target
]

{ #category : #accessing }
ToCommandOperator >> target: anEventTarget [

	target := anEventTarget
]
