Class {
	#name : #ToCommandTargetEventHandler,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'applicationTask'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'event handling' }
ToCommandTargetEventHandler >> commandAddedEvent: aCommandAddedEvent [

	| target |
	target := aCommandAddedEvent target.
	target isAttachedToSceneGraph ifFalse: [
		aCommandAddedEvent commandTarget apply.
		^ self ].
	applicationTask ifNotNil: [ ^ self ].
	applicationTask := BlTaskAction new action: [
		                       aCommandAddedEvent commandTarget apply.
		                       applicationTask := nil ].
	target enqueueTask: applicationTask.
	target requestLayout
]

{ #category : #'api - accessing' }
ToCommandTargetEventHandler >> eventsToHandle [

	^ { ToCommandAddedEvent }
]
