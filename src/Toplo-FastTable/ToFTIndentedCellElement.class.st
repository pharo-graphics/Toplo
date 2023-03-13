"
ToFTCell with adjustable indentation in the X axis that can be configured so that children will be laid out from indentation to #right.


"
Class {
	#name : #ToFTIndentedCellElement,
	#superclass : #ToFTCellElement,
	#instVars : [
		'indentation'
	],
	#category : #'Toplo-FastTable-Base'
}

{ #category : #layout }
ToFTIndentedCellElement >> addIndendtation: aNumber [

	indentation := indentation + aNumber + self cellInset
]

{ #category : #layout }
ToFTIndentedCellElement >> depthIndent: aNumber [

	aNumber timesRepeat: [ self addIndendtation: 16 ]
]

{ #category : #layout }
ToFTIndentedCellElement >> indentBy: aNumber [

	indentation := aNumber + self cellInset
]

{ #category : #initialization }
ToFTIndentedCellElement >> initialize [

	indentation := 0. "must be before super"

	super initialize.

	self cellInset: 2
]

{ #category : #layout }
ToFTIndentedCellElement >> layoutBounds [

	| inner |

	inner := self innerBounds.

	^indentation = 0
		ifTrue: [ inner ]
		ifFalse: [ ((indentation@0)+inner origin) corner: inner corner ]
]
