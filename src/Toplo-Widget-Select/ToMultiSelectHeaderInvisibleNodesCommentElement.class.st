Class {
	#name : #ToMultiSelectHeaderInvisibleNodesCommentElement,
	#superclass : #ToElement,
	#instVars : [
		'label',
		'invisibleCount'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #initialization }
ToMultiSelectHeaderInvisibleNodesCommentElement class >> initializeToRawTheme: aTheme [

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme when: ToInstallSkinEvent do: [ :e | 
				e addStyleSheetProperty: (ToFeatureProperty name: #commentText) ].
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #margin)
				with: [ :e |
					BlInsets horizontal: (e valueOfTokenNamed: #'padding-XXS') ].
			aTheme
				when: ToInstallSkinEvent
				write: #commentText asWritableProperty 
				with: [ :e |
						e invisibleCount isZero
							ifTrue: [ '' ]
							ifFalse: [ '+' , e invisibleCount asString ] ] ]
]

{ #category : #accessing }
ToMultiSelectHeaderInvisibleNodesCommentElement >> commentText [

	^ label text 
]

{ #category : #accessing }
ToMultiSelectHeaderInvisibleNodesCommentElement >> commentText: aTextOrString [

	label text asString = aTextOrString asString ifTrue: [ ^ self ].
	label text: aTextOrString
]

{ #category : #initialization }
ToMultiSelectHeaderInvisibleNodesCommentElement >> initialize [

	super initialize.
	self fitContent.
	invisibleCount := 0.
	label := ToLabel new.
	label constraintsDo: [ :c | c frame vertical alignCenter ].
	self elevation: (BlRelativeElevation elevation: 20).
	self constraintsDo: [ :c |
			c linear vertical alignCenter.
			c flow vertical alignCenter ].
	self addChild: label
]

{ #category : #accessing }
ToMultiSelectHeaderInvisibleNodesCommentElement >> invisibleCount [

	^ invisibleCount
]

{ #category : #accessing }
ToMultiSelectHeaderInvisibleNodesCommentElement >> invisibleCount: aNumber [

	invisibleCount := aNumber.
	self requestNewSkin
]

{ #category : #accessing }
ToMultiSelectHeaderInvisibleNodesCommentElement >> label [ 

	^ label
]
