Class {
	#name : #ToSelecterCommandApplicationRequest,
	#superclass : #BlInfiniteDataSourceRangeChanged,
	#instVars : [
		'command',
		'selecter'
	],
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #accessing }
ToSelecterCommandApplicationRequest >> command [

	^ command
]

{ #category : #accessing }
ToSelecterCommandApplicationRequest >> command: aCommand [

	command := aCommand
]

{ #category : #accessing }
ToSelecterCommandApplicationRequest >> selecter [

	^ selecter
]

{ #category : #accessing }
ToSelecterCommandApplicationRequest >> selecter: aSelecter [

	selecter := aSelecter
]

{ #category : #sending }
ToSelecterCommandApplicationRequest >> sendTo: anObject [

	anObject selecterCommandApplicationRequest: self
]
