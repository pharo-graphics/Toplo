"
ToFTCell with adjustable indentation in the X axis that can be configured so that children will be laid out from indentation to #right.


"
Class {
	#name : #ToFTIndentedCellMorph,
	#superclass : #ToFTCellMorph,
	#instVars : [
		'indentation'
	],
	#category : #'Toplo-FastTable-Base'
}

{ #category : #layout }
ToFTIndentedCellMorph >> addIndendtation: aNumber [

	indentation := indentation + aNumber + self cellInset
]

{ #category : #layout }
ToFTIndentedCellMorph >> depthIndent: aNumber [

	aNumber timesRepeat: [ self addIndendtation: 16 ]
]

{ #category : #layout }
ToFTIndentedCellMorph >> indentBy: aNumber [

	indentation := aNumber + self cellInset
]

{ #category : #initialization }
ToFTIndentedCellMorph >> initialize [

	indentation := 0. "must be before super"

	super initialize.

	self cellInset: 2
]

{ #category : #layout }
ToFTIndentedCellMorph >> layoutBounds [

	| inner |

	inner := self innerBounds.

	^indentation = 0
		ifTrue: [ inner ]
		ifFalse: [ ((indentation@0)+inner origin) corner: inner corner ]
]
