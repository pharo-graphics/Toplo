"
My class hierarchy models all the basic actions that can be made on a selection. 

"
Class {
	#name : #ToElementBasicCommand,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #'private - hook' }
ToElementBasicCommand >> applyOn: anOperator [

	" ask the operator passed as argument to actually apply the command. "

]

{ #category : #hook }
ToElementBasicCommand >> notifyAddedInOperator: anOperator forTarget: aTarget [
	" dispatch to the target to check the command and accept/deny the command application "

	| applicationEvent preNotification |
	applicationEvent := ToElementCommandApplicationEvent new
		                    operator: anOperator;
		                    command: self;
		                    yourself.
	preNotification := ToCommandPreApplicationEvent new
		                   sourceEvent: applicationEvent;
		                   yourself.
	anOperator dispatchPreNotificationEvent: preNotification
]

{ #category : #accessing }
ToElementBasicCommand >> target [

	^ target
]

{ #category : #accessing }
ToElementBasicCommand >> target: aScrollable [

	target := aScrollable
]
