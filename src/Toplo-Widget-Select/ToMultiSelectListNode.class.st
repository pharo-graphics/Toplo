Class {
	#name : #ToMultiSelectListNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #skin }
ToMultiSelectListNode >> installRawStyle [

	super installRawStyle.
	self holder selectElement withGroups ifTrue: [
		self holder isGroup
			ifTrue: [
				| label |
				self padding:
					((self padding withTop: self padding top + 6) withBottom:
						 self padding bottom + 3).
				label := self firstChild.
				label foreground: Color lightGray.
				label applyStyle ]
			ifFalse: [
			self padding: (self padding withLeft: self padding left + 6) ] ]
]
