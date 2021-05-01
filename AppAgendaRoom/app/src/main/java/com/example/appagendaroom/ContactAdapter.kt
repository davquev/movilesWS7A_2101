package com.example.appagendaroom

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.synthetic.main.prototype_contact.view.*

class ContactAdapter(val contacts: List<Contact>, val itemClickListener: OnItemClickListener): RecyclerView.Adapter<ContactProtype>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ContactProtype {
        val view = LayoutInflater
            .from(parent.context)
            .inflate(R.layout.prototype_contact, parent, false)

        return ContactProtype(view)
    }

    override fun onBindViewHolder(holder: ContactProtype, position: Int) {
        holder.bind(contacts.get(position), itemClickListener)
    }

    override fun getItemCount(): Int {
        return contacts.size
    }
}

class ContactProtype(itemView: View) : RecyclerView.ViewHolder(itemView) {
    val tvName = itemView.tvName
    val tvTelephone = itemView.tvTelephone
    val cvContact = itemView.cvContact

    fun bind(contact: Contact, itemClickListener: OnItemClickListener)
    {
        tvName.text = contact.name
        tvTelephone.text = contact.telephone

        cvContact.setOnClickListener {
            itemClickListener.OnItemClicked(contact)
        }
    }
}

interface OnItemClickListener{
    fun OnItemClicked(contact: Contact)
}
