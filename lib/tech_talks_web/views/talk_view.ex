defmodule TechTalksWeb.TalkView do
  use TechTalksWeb, :view

  defp options_for_select(values, options, value) do
    Enum.reduce values, options, fn
      {option_key, option_value}, acc ->
        [acc | option(option_key, option_value, [], value)]
      options, acc when is_list(options) ->
        {option_key, options} = Keyword.pop(options, :key)
        option_key || raise ArgumentError,
                            "expected :key key when building <option> from keyword list: #{inspect options}"

        {option_value, options} = Keyword.pop(options, :value)
        option_value || raise ArgumentError,
                              "expected :value key when building <option> from keyword list: #{inspect options}"

        [acc | option(option_key, option_value, options, value)]
      option, acc ->
        [acc | option(option, option, [], value)]
    end
  end

  defp option(group_label, group_values, [], value) when is_list(group_values) or is_map(group_values) do
    section_options = options_for_select(group_values, [], value)
    content_tag(:optgroup, section_options, label: group_label)
  end

  defp option(option_key, option_value, extra, value) do
    option_key   = html_escape(option_key)
    option_value = html_escape(option_value)

    selected =
      if is_list(value) do
        option_value in value
      else
        value == option_value
      end

    opts = [value: option_value, selected: selected] ++ extra
    content_tag(:option, option_key, opts)
  end

  def datalist_input(form, field, options, opts \\ []) do
    opts =
      opts
      |> Keyword.put_new(:id, input_id(form, field))
      |> Keyword.put_new(:name, input_name(form, field))
      |> Keyword.put_new(:value, input_value(form, field))
    content_tag(:datalist, options_for_select(options, "", ""), opts)
  end
end
