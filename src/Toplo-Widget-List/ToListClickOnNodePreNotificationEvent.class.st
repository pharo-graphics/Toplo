Class {
	#name : #ToListClickOnNodePreNotificationEvent,
	#superclass : #ToListChangePreNotificationEvent,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListClickOnNodePreNotificationEvent >> node [

	^ node
]

{ #category : #accessing }
ToListClickOnNodePreNotificationEvent >> node: aNode [

	node := aNode
]

{ #category : #sending }
ToListClickOnNodePreNotificationEvent >> sendTo: anObject [

	anObject listClickOnNodePreNotificationEvent: self
]
