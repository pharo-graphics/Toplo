Class {
	#name : #ToMultiSelectHeaderInvisibleNodesCommentElement,
	#superclass : #ToElement,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #initialization }
ToMultiSelectHeaderInvisibleNodesCommentElement class >> initializeToRawTheme: aTheme [

	<toploThemeInstallerFor: #ToRawTheme>
	
	aTheme
		select: (self asTypeSelector exact: false)
		style: [ " install the font and the text foreground for a label in a badge "
				aTheme
					when: ToInstallSkinEvent
					write: (aTheme property: #margin)
					with: [ :e |
						BlInsets horizontal:
							(e valueOfTokenNamed: #'bar-node-padding-H') ] ]
]

{ #category : #initialization }
ToMultiSelectHeaderInvisibleNodesCommentElement >> initialize [

	super initialize.
	self fitContent.
	label := ToLabel new.
	label constraintsDo: [ :c | c frame vertical alignCenter ].
	self elevation: (BlRelativeElevation elevation: 20).
	self constraintsDo: [ :c |
			c linear vertical alignCenter.
			c flow vertical alignCenter ].
	self addChild: label
]

{ #category : #accessing }
ToMultiSelectHeaderInvisibleNodesCommentElement >> label [ 

	^ label
]

{ #category : #accessing }
ToMultiSelectHeaderInvisibleNodesCommentElement >> text: aTextOrString [

	label text asString = aTextOrString asString ifTrue: [ ^ self ].
	label text: aTextOrString
]
