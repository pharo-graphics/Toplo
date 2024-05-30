Class {
	#name : #ToElementCommandApplicationEvent,
	#superclass : #ToElementCommandEvent,
	#instVars : [
		'operator'
	],
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #accessing }
ToElementCommandApplicationEvent >> operator [

	^ operator
]

{ #category : #accessing }
ToElementCommandApplicationEvent >> operator: anOperator [

	operator := anOperator
]

{ #category : #sending }
ToElementCommandApplicationEvent >> sendTo: anObject [

		anObject elementCommandApplicationEvent: self
]
