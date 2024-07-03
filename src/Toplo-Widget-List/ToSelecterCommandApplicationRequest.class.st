Class {
	#name : #ToSelecterCommandApplicationRequest,
	#superclass : #BlInfiniteDataSourceRangeChanged,
	#instVars : [
		'command',
		'applier'
	],
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #accessing }
ToSelecterCommandApplicationRequest >> applier [

	^ applier
]

{ #category : #accessing }
ToSelecterCommandApplicationRequest >> applier: anApplier [

	applier := anApplier
]

{ #category : #accessing }
ToSelecterCommandApplicationRequest >> command [

	^ command
]

{ #category : #accessing }
ToSelecterCommandApplicationRequest >> command: aCommand [

	command := aCommand
]

{ #category : #sending }
ToSelecterCommandApplicationRequest >> sendTo: anObject [

	anObject selecterCommandApplicationRequest: self
]
