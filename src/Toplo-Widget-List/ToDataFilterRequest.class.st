Class {
	#name : 'ToDataFilterRequest',
	#superclass : 'BlEvent',
	#instVars : [
		'pattern'
	],
	#category : 'Toplo-Widget-List-Filter',
	#package : 'Toplo-Widget-List',
	#tag : 'Filter'
}

{ #category : 'accessing' }
ToDataFilterRequest >> pattern [

	^ pattern
]

{ #category : 'accessing' }
ToDataFilterRequest >> pattern: anObject [

	pattern := anObject
]

{ #category : 'sending' }
ToDataFilterRequest >> sendTo: anObject [

	anObject dataFilterRequest: self
]
