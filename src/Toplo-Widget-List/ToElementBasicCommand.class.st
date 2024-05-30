"
My class hierarchy models all the basic actions that can be made on a selection. 

"
Class {
	#name : #ToElementBasicCommand,
	#superclass : #Object,
	#instVars : [
		'operator',
		'target'
	],
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #'private - hook' }
ToElementBasicCommand >> applyOn: anOperator [

	" ask the operator passed as argument to actually apply the command. "

]

{ #category : #hook }
ToElementBasicCommand >> notifyIn: aTarget [
	" dispatch to the target to check the command and accept/deny the command application "

	| applicationEvent preNotification |
	applicationEvent := ToElementCommandApplicationEvent new
		                    command: self;
		                    operator: self operator;
		                    yourself.
	preNotification := ToCommandPreApplicationEvent new
		                   sourceEvent: applicationEvent;
		                   yourself.
	aTarget dispatchPreNotificationEvent: preNotification
]

{ #category : #accessing }
ToElementBasicCommand >> operator [

	^ operator
]

{ #category : #accessing }
ToElementBasicCommand >> operator: aSelectionModelOperator [

	operator := aSelectionModelOperator
]

{ #category : #accessing }
ToElementBasicCommand >> target [

	^ target
]

{ #category : #accessing }
ToElementBasicCommand >> target: aScrollable [

	target := aScrollable
]
