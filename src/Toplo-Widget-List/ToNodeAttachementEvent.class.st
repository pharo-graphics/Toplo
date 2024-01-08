Class {
	#name : #ToNodeAttachementEvent,
	#superclass : #BlEvent,
	#instVars : [
		'attached'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToNodeAttachementEvent >> attached [

	^ attached
]

{ #category : #accessing }
ToNodeAttachementEvent >> attached: aBoolean [

	attached := aBoolean
]
