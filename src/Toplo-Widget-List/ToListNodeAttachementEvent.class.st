Class {
	#name : #ToListNodeAttachementEvent,
	#superclass : #BlEvent,
	#instVars : [
		'attached'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToListNodeAttachementEvent >> attached [

	^ attached
]

{ #category : #accessing }
ToListNodeAttachementEvent >> attached: aBoolean [

	attached := aBoolean
]
