Class {
	#name : #ToLabelChanged,
	#superclass : #Announcement,
	#instVars : [
		'text'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #accessing }
ToLabelChanged >> text [
	<return: #BlText or: #String>

	^ text
]

{ #category : #accessing }
ToLabelChanged >> text: aBrTextOrString [
	self
		assert: [ aBrTextOrString isNotNil ]
		description: [ 'Text must not be nil' ].

	text := aBrTextOrString
]
