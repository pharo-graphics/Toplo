Class {
	#name : #ToLabelledBadge,
	#superclass : #ToBadge,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToLabelledBadge >> initialize [

	super initialize.
	label := ToLabel text: ''.
	label bold.
	label constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
	self builder: [ :inner | inner addChild: label ].
	self tooltipBuilder: [ :window :request |
			window root addChild: ((ToLabel text: label text copy)
					 defaultRawSkin: ToLabelInTooltipSkin new;
					 yourself) ]
]

{ #category : #accessing }
ToLabelledBadge >> label [

	^ label
]

{ #category : #accessing }
ToLabelledBadge >> labelText: aTextOrString [

	self label text: aTextOrString
]
